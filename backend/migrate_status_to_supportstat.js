import pg from 'pg';
import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
dotenv.config({ path: path.join(__dirname, '.env') });

const { Pool } = pg;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || '5432', 10),
});

async function migrate() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    console.log('Dropping tickets_status_check constraint if exists...');
    await client.query(`ALTER TABLE tickets DROP CONSTRAINT IF EXISTS tickets_status_check`);
    
    console.log('Updating default value for status to "O"...');
    await client.query(`ALTER TABLE tickets ALTER COLUMN status SET DEFAULT 'O'`);
    
    console.log('Migrating existing statuses to SupportStat codes...');
    const resOpen = await client.query(`UPDATE tickets SET status = 'O' WHERE status = 'open'`);
    console.log(`- Updated ${resOpen.rowCount} tickets from 'open' to 'O'`);
    
    const resAssigned = await client.query(`UPDATE tickets SET status = 'I' WHERE status = 'assigned'`);
    console.log(`- Updated ${resAssigned.rowCount} tickets from 'assigned' to 'I'`);
    
    const resResolved = await client.query(`UPDATE tickets SET status = 'C' WHERE status = 'resolved'`);
    console.log(`- Updated ${resResolved.rowCount} tickets from 'resolved' to 'C'`);
    
    await client.query('COMMIT');
    console.log('Migration completed successfully!');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Migration failed:', error);
  } finally {
    client.release();
    pool.end();
  }
}

migrate();
