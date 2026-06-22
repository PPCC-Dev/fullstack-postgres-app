import pool from './src/config/db.js';
const res = await pool.query("SELECT column_name FROM information_schema.columns WHERE table_name = 'tickets';");
console.log(res.rows.map(r => r.column_name).join(', '));
process.exit(0);
