import pool from './src/config/db.js';

async function updateSeq() {
  try {
    console.log('Adding seq column to support_stats...');
    await pool.query('ALTER TABLE support_stats ADD COLUMN IF NOT EXISTS seq INTEGER DEFAULT 9999;');

    const res = await pool.query('SELECT stat, description FROM support_stats');
    for (const row of res.rows) {
      const match = row.description.match(/^(\d{3})/);
      let seq = 9999;
      if (match) {
        seq = parseInt(match[1], 10);
      }
      await pool.query('UPDATE support_stats SET seq = $1 WHERE stat = $2', [seq, row.stat]);
      console.log(`Updated ${row.stat} with seq ${seq}`);
    }
    
    console.log('Finished updating seq.');
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

updateSeq();
