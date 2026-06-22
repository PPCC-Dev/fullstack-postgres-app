import pg from 'pg';
import dotenv from 'dotenv';
dotenv.config();

const pool = new pg.Pool({
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE,
});

async function run() {
  try {
    const ticketsQuery = `
      SELECT t.*, 
             COALESCE(pt.name, t.program_type) as program_type,
             c.name as customer_name, c.cust_num as customer_cust_num,
             a.name as agent_name,
             cust.cust_name as actual_customer_name
      FROM tickets t
      LEFT JOIN users c ON t.customer_id = c.id
      LEFT JOIN users a ON t.agent_id = a.id
      LEFT JOIN program_types pt ON t.program_type = pt.value
      LEFT JOIN customers cust ON t.cust_num = cust.cust_num
      WHERE 1=1 
      ORDER BY t.created_at DESC
    `;
    const ticketsResult = await pool.query(ticketsQuery, []);
    console.log('Tickets count:', ticketsResult.rows.length);

    const avgTimeResult = await pool.query(`
      SELECT AVG(EXTRACT(EPOCH FROM (resolved_at - created_at))) as avg_seconds
      FROM tickets 
      WHERE status IN ('resolved', 'C') AND resolved_at IS NOT NULL 
    `, []);
    console.log('Avg time:', avgTimeResult.rows[0].avg_seconds);
  } catch(e) {
    console.error('Error:', e);
  } finally {
    pool.end();
  }
}
run();
