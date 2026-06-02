import pkg from 'pg';
const { Pool } = pkg;
import dotenv from 'dotenv';

dotenv.config();

const pool = new Pool({
  user: process.env.DB_USER || 'tunited',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_DATABASE || 'apex_support_db',
  password: process.env.DB_PASSWORD || '',
  port: process.env.DB_PORT || 5433,
});

async function migrate() {
  try {
    await pool.query('ALTER TABLE modules ADD COLUMN IF NOT EXISTS description VARCHAR(255);');
    console.log('Successfully added description column to modules table.');
  } catch (error) {
    console.error('Error adding column:', error);
  } finally {
    pool.end();
  }
}

migrate();
