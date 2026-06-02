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
  const client = await pool.connect();
  try {
    console.log('Running expansion schema migration...');

    // 1. Add is_internal to messages
    await client.query(`
      ALTER TABLE messages ADD COLUMN IF NOT EXISTS is_internal BOOLEAN DEFAULT FALSE;
    `);
    console.log('1. Column is_internal added to messages table successfully (or already exists).');

    // 2. Create notifications table
    await client.query(`
      CREATE TABLE IF NOT EXISTS notifications (
        id SERIAL PRIMARY KEY,
        user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
        title VARCHAR(200) NOT NULL,
        message TEXT NOT NULL,
        is_read BOOLEAN DEFAULT FALSE,
        type VARCHAR(50),
        ticket_id INTEGER REFERENCES tickets(id) ON DELETE CASCADE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);
    console.log('2. Notifications table verified/created successfully.');

    // 3. Create index on notifications for fast retrieval
    await client.query(`
      CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id);
      CREATE INDEX IF NOT EXISTS idx_notifications_unread ON notifications(user_id, is_read);
    `);
    console.log('3. Performance indexes created successfully.');

    console.log('✅ Expansion schema migration completed successfully!');
  } catch (error) {
    console.error('❌ Error during expansion migration:', error);
  } finally {
    client.release();
    pool.end();
  }
}

migrate();
