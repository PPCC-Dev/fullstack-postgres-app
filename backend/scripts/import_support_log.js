import fs from 'fs';
import csv from 'csv-parser';
import pg from 'pg';

const { Pool } = pg;
const pool = new Pool({
  user: 'tunited',
  host: 'localhost',
  database: 'apex_support_db',
  password: '',
  port: 5433,
});

async function run() {
  const records = [];
  
  await new Promise((resolve, reject) => {
    fs.createReadStream('./support_log_utf8.csv')
      .pipe(csv({ separator: '\t', headers: false }))
      .on('data', (row) => records.push(row))
      .on('end', resolve)
      .on('error', reject);
  });

  console.log(`Parsed ${records.length} rows.`);

  let successCount = 0;
  let errorCount = 0;

  for (const row of records) {
    if (row[0] === 'Log Id' || !row[0]) continue; // Skip header or empty rows

    const ticketNumber = row[0];
    const statusRaw = row[4];
    const custNum = row[5];
    const contactName = row[7];
    const submittedDateRaw = row[8];
    const timeRaw = row[9];
    const subject = row[10];
    const problemDesc = row[11];
    const moduleName = row[12];
    const formName = row[13];
    const programType = row[15] || 'Standard';
    const problem = row[16];
    const issueType = row[17] || 'Technical';
    const cause = row[19];
    const solution = row[20];
    const agentAlias = row[22];
    const projectedDateRaw = row[24];
    const closedByAlias = row[25];
    const closedDateRaw = row[26];
    const remark = row[29];
    const severityRaw = row[31];

    const description = problem || problemDesc || '-';
    const title = subject || '-';

    let status = 'open';
    if (statusRaw && statusRaw.toLowerCase().includes('closed')) status = 'resolved';
    else if (statusRaw && statusRaw.toLowerCase().includes('progress')) status = 'assigned';

    let priority = 'medium';
    if (severityRaw && severityRaw.toLowerCase().includes('high')) priority = 'high';
    else if (severityRaw && severityRaw.toLowerCase().includes('low')) priority = 'low';
    
    const formatDate = (dateStr) => {
      if (!dateStr || dateStr.trim() === '') return null;
      const parts = dateStr.trim().split('/');
      if (parts.length === 3) return `${parts[2]}-${parts[1]}-${parts[0]}`; // DD/MM/YYYY -> YYYY-MM-DD
      return null;
    };
    
    const requestDate = formatDate(submittedDateRaw);
    let requestTime = null;
    if (timeRaw && timeRaw.trim() !== '') {
        const t = timeRaw.trim();
        // Extract HH:MM
        if (t.match(/^\d{2}:\d{2}$/)) {
            requestTime = t + ':00';
        } else if (t.match(/^\d{4}$/)) {
            requestTime = t.substring(0,2) + ':' + t.substring(2,4) + ':00';
        }
    }

    const projectedDate = formatDate(projectedDateRaw);
    const resolvedAt = formatDate(closedDateRaw); // Postgres casts YYYY-MM-DD to timestamp

    // Lookup Agent ID
    let agentId = null;
    if (agentAlias && agentAlias.trim() !== '') {
      const cleanAlias = agentAlias.trim();
      const email = `${cleanAlias.toLowerCase().replace(/[^a-z0-9]/g, '')}@apex.com`;
      const res = await pool.query('SELECT id FROM users WHERE email = $1', [email]);
      if (res.rows.length > 0) agentId = res.rows[0].id;
      else {
         const insertRes = await pool.query('INSERT INTO users (name, email, password_hash, role) VALUES ($1, $2, $3, $4) RETURNING id', [cleanAlias, email, 'dummy', 'agent']);
         agentId = insertRes.rows[0].id;
      }
    }

    let resolvedBy = null;
    if (closedByAlias && closedByAlias.trim() !== '') {
      const cleanAlias = closedByAlias.trim();
      const email = `${cleanAlias.toLowerCase().replace(/[^a-z0-9]/g, '')}@apex.com`;
      const res = await pool.query('SELECT id FROM users WHERE email = $1', [email]);
      if (res.rows.length > 0) resolvedBy = res.rows[0].id;
      else {
         const insertRes = await pool.query('INSERT INTO users (name, email, password_hash, role) VALUES ($1, $2, $3, $4) RETURNING id', [cleanAlias, email, 'dummy', 'agent']);
         resolvedBy = insertRes.rows[0].id;
      }
    }

    // Customer setup
    let customerId = null;
    if (custNum && custNum.trim() !== '') {
      const cleanCust = custNum.trim();
      const res = await pool.query('SELECT cust_num FROM customers WHERE cust_num = $1', [cleanCust]);
      if (res.rows.length === 0) {
        await pool.query('INSERT INTO customers (cust_num, cust_name) VALUES ($1, $2) ON CONFLICT DO NOTHING', [cleanCust, cleanCust]);
      }
    }

    try {
      await pool.query(`
        INSERT INTO tickets (
          ticket_number, title, description, status, priority, cust_num, contact_name,
          module, form_name, program_type, issue_type, cause, solution, remark,
          request_date, request_time, projected_date, resolved_at, agent_id, resolved_by, customer_id
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21)
        ON CONFLICT (ticket_number) DO UPDATE SET
          title = EXCLUDED.title,
          description = EXCLUDED.description,
          status = EXCLUDED.status,
          cause = EXCLUDED.cause,
          solution = EXCLUDED.solution,
          remark = EXCLUDED.remark
      `, [
        ticketNumber, title, description, status, priority, custNum ? custNum.trim() : null, contactName ? contactName.trim() : null,
        moduleName ? moduleName.trim() : 'Unknown', formName ? formName.trim() : null, programType, issueType, cause ? cause.trim() : null, solution ? solution.trim() : null, remark ? remark.trim() : null,
        requestDate, requestTime, projectedDate, resolvedAt, agentId, resolvedBy, customerId
      ]);
      successCount++;
    } catch (err) {
      console.error(`Failed to insert ticket ${ticketNumber}:`, err.message);
      errorCount++;
    }
  }

  console.log(`Import completed. Success: ${successCount}, Errors: ${errorCount}`);
  pool.end();
}

run();
