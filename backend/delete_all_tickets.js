import pool from './src/config/db.js';

async function deleteAllTickets() {
  try {
    console.log('Deleting all tickets and associated records...');
    
    // 1. Truncate notifications table
    await pool.query('TRUNCATE notifications CASCADE');
    console.log('Truncated notifications table.');

    // 2. Truncate ticket_attachments table
    await pool.query('TRUNCATE ticket_attachments CASCADE');
    console.log('Truncated ticket_attachments table.');

    // 3. Truncate messages table
    await pool.query('TRUNCATE messages CASCADE');
    console.log('Truncated messages table.');

    // 4. Truncate tickets table
    await pool.query('TRUNCATE tickets CASCADE');
    console.log('Truncated tickets table.');

    console.log('--- All tickets deleted successfully! ---');
    process.exit(0);
  } catch (error) {
    console.error('Error deleting tickets:', error);
    process.exit(1);
  }
}

deleteAllTickets();
