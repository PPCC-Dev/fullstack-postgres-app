import pool from './src/config/db.js';

async function setupSupportStatsTable() {
  try {
    console.log('Setting up support_stats table in PostgreSQL...');
    
    // 1. Create table
    await pool.query(`
      CREATE TABLE IF NOT EXISTS support_stats (
        stat VARCHAR(10) PRIMARY KEY,
        description VARCHAR(255) NOT NULL,
        remark TEXT
      );
    `);
    console.log('Created support_stats table successfully.');

    // 2. Seed baseline data
    const baselineData = [
      { stat: 'C', description: '999-Closed', remark: '' },
      { stat: 'D', description: '030-Identify', remark: 'assumption - Cust Bug - STD Bug / Under Design' },
      { stat: 'F', description: '120-Awaiting Infor', remark: '' },
      { stat: 'I', description: '050-In-Process', remark: 'Editing or Doing' },
      { stat: 'M', description: 'Monitor', remark: '' },
      { stat: 'N', description: 'Not Accept', remark: 'Not Accept' },
      { stat: 'O', description: '010-Open', remark: '1st Level Support log into system' },
      { stat: 'Q', description: '060-Intemal PPCC QC', remark: 'Testing on PPCC Server' },
      { stat: 'S', description: '040-Solution Finding', remark: 'Find solution, Method how to solve' },
      { stat: 'T', description: '080-Test on CRP/UAT-QC', remark: 'Testing on Customer Server (CRP / UAT)' },
      { stat: 'V', description: '020-Investigate', remark: 'When DEV/Supp pull that log to investigate' },
      { stat: 'W', description: '100-Awaiting Customer', remark: 'Waiting to Customer' }
    ];

    for (const row of baselineData) {
      await pool.query(`
        INSERT INTO support_stats (stat, description, remark)
        VALUES ($1, $2, $3)
        ON CONFLICT (stat) DO UPDATE
        SET description = EXCLUDED.description, remark = EXCLUDED.remark
      `, [row.stat, row.description, row.remark]);
    }
    console.log('Seeded support_stats data successfully.');

    console.log('--- Database Setup Completed! ---');
    process.exit(0);
  } catch (error) {
    console.error('Error during setup:', error);
    process.exit(1);
  }
}

setupSupportStatsTable();
