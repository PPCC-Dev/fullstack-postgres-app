import pool from './src/config/db.js';

async function createTestTicket() {
  try {
    // 1. Look for any customer
    let userRes = await pool.query(
      `SELECT * FROM users WHERE role = 'customer' LIMIT 1`
    );
    
    let customer;
    if (userRes.rows.length === 0) {
      console.log('No customer user found. Checking for any user...');
      // Look for ANY user
      userRes = await pool.query(`SELECT * FROM users LIMIT 1`);
      
      if (userRes.rows.length === 0) {
        console.log('No users at all! Creating a temporary customer user...');
        // Insert a temporary customer user
        const newCustRes = await pool.query(
          `INSERT INTO users (name, email, password_hash, role, cust_num, is_verified)
           VALUES ($1, $2, $3, $4, $5, $6)
           RETURNING *`,
          ['ลูกค้าทดสอบ (Test Customer)', 'customer.test@ppcc.co.th', '$2b$10$xyz', 'customer', 'CUST001', true]
        );
        customer = newCustRes.rows[0];
        console.log(`Created customer: ${customer.name}`);
      } else {
        customer = userRes.rows[0];
        console.log(`Using existing user: ${customer.name} (Role: ${customer.role})`);
      }
    } else {
      customer = userRes.rows[0];
      console.log(`Using existing customer: ${customer.name}`);
    }
    
    // 2. Ensure customer.cust_num exists in customers table
    let custNum = customer.cust_num || 'CUST001';
    const custCheck = await pool.query(
      `SELECT * FROM customers WHERE cust_num = $1`,
      [custNum]
    );
    if (custCheck.rows.length === 0) {
      // Insert mock customer if missing
      await pool.query(
        `INSERT INTO customers (cust_num, cust_name) VALUES ($1, $2)`,
        [custNum, `${customer.name} Org`]
      );
      console.log(`Inserted mock customer org with cust_num: ${custNum}`);
    }

    // Update user cust_num to keep referential integrity
    await pool.query(
      `UPDATE users SET cust_num = $1 WHERE id = $2`,
      [custNum, customer.id]
    );

    // 3. Generate a ticket number
    const ticketNum = 'TK-' + Date.now().toString().slice(-6);

    // 4. Insert ticket
    const title = '⚠️ ทดสอบความเสถียรของระบบ: มีปัญหาในการดาวน์โหลดรายงานสรุปประจำเดือน';
    const description = 'พบปัญหาเมื่อเข้าหน้าดาวน์โหลดรายงาน PDF หน้าจอค้างและไม่ตอบสนอง รบกวนเจ้าหน้าที่ช่วยตรวจสอบ Log การทำงานในฐานข้อมูลให้ด้วยครับ ขอบคุณครับ\n\n(นี่คือตั๋วทดสอบระบบแจ้งเตือนแบบเรียลไทม์และตัวสถิติแดชบอร์ด)';
    const priority = 'high';
    const category = 'Technical';
    const module = 'GL';
    const programType = 'Standard';
    const issueType = 'Technical';

    const insertTicketRes = await pool.query(
      `INSERT INTO tickets (ticket_number, title, description, category, module, program_type, issue_type, priority, status, customer_id, cust_num)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, 'open', $9, $10)
       RETURNING *`,
      [ticketNum, title, description, category, module, programType, issueType, priority, customer.id, custNum]
    );

    const ticket = insertTicketRes.rows[0];
    console.log(`Successfully created ticket! ID: ${ticket.id}, Number: ${ticket.ticket_number}`);

    // 5. Create in-app notifications for Admins and Agents
    const adminsAgentsRes = await pool.query(
      `SELECT id FROM users WHERE role IN ('admin', 'agent')`
    );

    const notifTitle = `🎫 ตั๋วใหม่: ${ticket.ticket_number}`;
    const notifMsg = `${customer.name} ได้เปิดเคสใหม่: "${ticket.title}"`;
    
    for (const staff of adminsAgentsRes.rows) {
      await pool.query(
        `INSERT INTO notifications (user_id, title, message, type, ticket_id)
         VALUES ($1, $2, $3, 'ticket_created', $4)`,
        [staff.id, notifTitle, notifMsg, ticket.id]
      );
      console.log(`Created notification for staff ID: ${staff.id}`);
    }

    console.log('--- Test ticket creation complete! ---');
    process.exit(0);
  } catch (error) {
    console.error('Error creating test ticket:', error);
    process.exit(1);
  }
}

createTestTicket();
