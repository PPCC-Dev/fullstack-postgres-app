import fs from 'fs';
import path from 'path';
import csv from 'csv-parser';
import pool from '../src/config/db.js'; // Adjust path if needed
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function importData() {
  const csvFilePath = path.join(__dirname, '../../support_log.csv');
  console.log('Reading CSV from:', csvFilePath);

  // Fetch users for mapping
  const usersResult = await pool.query('SELECT id, name, role, cust_num FROM users');
  const users = usersResult.rows;

  // Fetch customers for cust_num validation
  const custResult = await pool.query('SELECT cust_num FROM customers');
  const validCustNums = new Set(custResult.rows.map(r => r.cust_num));

  const getCustomerId = (custNum) => {
    if (!custNum) return null;
    const user = users.find(u => u.cust_num === custNum && u.role.toLowerCase() === 'customer');
    return user ? user.id : null;
  };

  const getAgentId = (agentName) => {
    if (!agentName) return null;
    const user = users.find(u => u.name === agentName && (u.role.toLowerCase() === 'agent' || u.role.toLowerCase() === 'admin'));
    return user ? user.id : null;
  };

  const ticketsToInsert = [];
  let successCount = 0;
  let skipCount = 0;

  fs.createReadStream(csvFilePath)
    // Strip BOM using a transform stream or directly in csv-parser if supported. We'll handle it manually just in case
    .pipe(csv({
      mapHeaders: ({ header }) => header.replace(/^\uFEFF/, '').trim()
    }))
    .on('data', (row) => {
      // Map columns based on Implementation Plan
      
      const ticket_number = row['log_id'];
      if (!ticket_number) {
        skipCount++;
        return; // skip if no ticket number
      }

      // We use 'stat' but it contains values like 'C', 'O', 'I'
      const status = row['stat'] || 'O';
      let cust_num = row['cust_num'];
      if (!validCustNums.has(cust_num)) {
        cust_num = null; // Set to null if not exists in customers table
      }
      const customer_id = getCustomerId(cust_num);
      
      let title = row['subject'];
      let description = row['problem'];
      if (!title || title.trim() === '') {
        title = description ? description.substring(0, 100) : 'Untitled Ticket';
      }
      if (title && title.length > 200) {
        title = title.substring(0, 197) + '...';
      }
      if (!description || description.trim() === '') {
        description = title || 'No description provided';
      }

      let priority = (row['Severity'] || '').toLowerCase();
      if (!['low', 'medium', 'high'].includes(priority)) {
        priority = 'medium';
      }
      const moduleStr = row['module'] || null;
      const form_name = row['form'] || null;
      const issue_type = row['error_type'] || null;
      const program_type = row['type'] || row['prog_group'] || null;
      const solution = row['solution'] || null;
      const workaround = row['current_solution'] || null;
      
      const agent_id = getAgentId(row['respond_by']);
      const resolved_by = getAgentId(row['closed_by']);
      const additional_email = row['email'] || null;

      ticketsToInsert.push({
        ticket_number,
        status,
        cust_num,
        customer_id,
        title,
        description,
        priority,
        module: moduleStr,
        form_name,
        issue_type,
        program_type,
        solution,
        workaround,
        agent_id,
        resolved_by,
        additional_email
      });
    })
    .on('end', async () => {
      console.log(`Parsed ${ticketsToInsert.length} records. Starting DB insert...`);
      
      const client = await pool.connect();
      try {
        await client.query('BEGIN');
        
        for (const t of ticketsToInsert) {
          // Check if ticket already exists
          const checkRes = await client.query('SELECT id FROM tickets WHERE ticket_number = $1', [t.ticket_number]);
          if (checkRes.rows.length > 0) {
            console.log(`Ticket ${t.ticket_number} already exists, skipping...`);
            skipCount++;
            continue;
          }

          const insertQuery = `
            INSERT INTO tickets (
              ticket_number, status, cust_num, customer_id, title, description,
              priority, module, form_name, issue_type, program_type,
              solution, workaround, agent_id, resolved_by, additional_email, created_at, updated_at
            ) VALUES (
              $1, $2, $3, $4, $5, $6,
              $7, $8, $9, $10, $11,
              $12, $13, $14, $15, $16, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
            )
          `;
          const values = [
            t.ticket_number, t.status, t.cust_num, t.customer_id, t.title, t.description,
            t.priority, t.module, t.form_name, t.issue_type, t.program_type,
            t.solution, t.workaround, t.agent_id, t.resolved_by, t.additional_email
          ];
          
          await client.query(insertQuery, values);
          successCount++;
        }

        await client.query('COMMIT');
        console.log(`Import finished! Successfully inserted ${successCount} records. Skipped ${skipCount} records.`);
      } catch (err) {
        await client.query('ROLLBACK');
        console.error('Error inserting records. Transaction rolled back.', err);
      } finally {
        client.release();
        process.exit(0);
      }
    })
    .on('error', (err) => {
      console.error('Error reading CSV:', err);
      process.exit(1);
    });
}

importData().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
