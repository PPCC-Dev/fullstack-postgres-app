import pool from './src/config/db.js';

async function checkAdmins() {
  try {
    const res = await pool.query('SELECT id, name, email, role FROM users');
    console.log('--- ALL USERS ---');
    console.table(res.rows);

    const rolesRes = await pool.query('SELECT * FROM roles');
    console.log('--- ALL ROLES ---');
    console.table(rolesRes.rows);

    const adminsRes = await pool.query(`
      SELECT u.id, u.name, u.email, u.role, r.base_role, COALESCE(r.base_role, u.role) as final_role
      FROM users u
      LEFT JOIN roles r ON LOWER(u.role) = LOWER(r.name)
      WHERE LOWER(COALESCE(r.base_role, u.role)) IN ('admin', 'agent')
    `);
    console.log('--- RESOLVED ADMINS/AGENTS ---');
    console.table(adminsRes.rows);
  } catch (err) {
    console.error(err);
  } finally {
    await pool.end();
  }
}

checkAdmins();
