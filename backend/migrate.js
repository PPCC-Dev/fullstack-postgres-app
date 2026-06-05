import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const { Pool } = pg;
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT || '5432', 10),
});

const migrate = async () => {
  try {
    await pool.query('ALTER TABLE public.customers ADD COLUMN IF NOT EXISTS prefix character varying(50);');
    console.log('Successfully added prefix column to customers table');
  } catch (error) {
    console.error('Migration failed:', error);
  } finally {
    await pool.end();
  }
};

migrate();
