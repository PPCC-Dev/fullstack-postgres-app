import fs from 'fs';
import csv from 'csv-parser';
import pool from '../src/config/db.js';
import { Readable } from 'stream';

const importData = async () => {
  const results = [];
  const filePath = '/Users/tunited/Projects/fullstack-postgres-app/customer_contract.csv';
  
  if (!fs.existsSync(filePath)) {
    console.error(`File not found: ${filePath}`);
    process.exit(1);
  }

  // Read file as UTF-16LE
  const content = fs.readFileSync(filePath, 'utf16le');
  
  // Remove BOM if present
  const cleanContent = content.charCodeAt(0) === 0xFEFF ? content.slice(1) : content;
  
  const stream = Readable.from(cleanContent);

  stream
    .pipe(csv({ separator: '\t' }))
    .on('data', (data) => results.push(data))
    .on('end', async () => {
      console.log(`Parsed ${results.length} rows from CSV.`);
      
      let inserted = 0;
      let errors = 0;

      for (const row of results) {
        // Handle BOM in column name if still present
        const contractNameKey = Object.keys(row).find(k => k.includes('ContractName'));
        
        const contract_name = row[contractNameKey] || '';
        const cust_num = row['CustNum'] || '';
        const first_name = row['First Name'] || '';
        const last_name = row['Last Name'] || '';
        const department = row['Department'] || '';
        const email = row['E-mail'] || '';
        const phone = row['Phone'] || '';
        const tel = row['Tel.'] || '';

        try {
          await pool.query(
            `INSERT INTO customer_contracts (contract_name, cust_num, first_name, last_name, department, email, phone, tel)
             VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
            [contract_name, cust_num, first_name, last_name, department, email, phone, tel]
          );
          inserted++;
        } catch (err) {
          console.error(`Error inserting row for ${contract_name}:`, err.message);
          errors++;
        }
      }

      console.log(`Import completed. Inserted: ${inserted}, Errors: ${errors}`);
      process.exit(0);
    });
};

importData();
