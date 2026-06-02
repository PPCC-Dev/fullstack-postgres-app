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

const modules = [
  { name: 'ALL', description: 'ALL' },
  { name: 'AM', description: 'AutoMotion' },
  { name: 'AP', description: 'Accounts Payable' },
  { name: 'APM', description: 'Appointment' },
  { name: 'AR', description: 'Accounts Receivable' },
  { name: 'Automation', description: 'Web Automation' },
  { name: 'BC', description: 'Barcode' },
  { name: 'BG', description: 'Budgets' },
  { name: 'BOM', description: 'Bill of Materials' },
  { name: 'CO', description: 'Customer Order' },
  { name: 'Co-Product', description: 'Co-Product' },
  { name: 'CSF', description: 'CashFlow' },
  { name: 'CST', description: 'Costing' },
  { name: 'CU', description: 'Customer' },
  { name: 'CUR', description: 'Customer Rating' },
  { name: 'Cycle', description: 'Cycle Count' },
  { name: 'DO', description: 'Delivery Order' },
  { name: 'EDI', description: 'EDI' },
  { name: 'EVM', description: 'Event Management' },
  { name: 'FA', description: 'Fixed Assets' },
  { name: 'FC', description: 'Forecast' },
  { name: 'FNS', description: 'Financial Statements' },
  { name: 'FS', description: 'Field Service' },
  { name: 'FTM', description: 'FTM' },
  { name: 'GL', description: 'General Ledger' },
  { name: 'IC', description: 'Inventory Control' },
  { name: 'ISH', description: 'I-Cash' },
  { name: 'Item', description: 'Item' },
  { name: 'MAS', description: 'Master Data' },
  { name: 'MB', description: 'Mobile' },
  { name: 'MIA', description: 'Material Issue Approval' },
  { name: 'Milk Run', description: 'Milk Run' },
  { name: 'OLS', description: 'OLS' },
  { name: 'Oth', description: 'Other' },
  { name: 'PAJ', description: 'Price Adjustment' },
  { name: 'PJC', description: 'Projects' },
  { name: 'PLN', description: 'Planning' },
  { name: 'PO', description: 'Purchase Order' },
  { name: 'PR', description: 'Purchase Order Requisitions' },
  { name: 'PS', description: 'Production Schedule' },
  { name: 'QCS', description: 'Quality Control System' },
  { name: 'RMA', description: 'RMA' },
  { name: 'SA', description: 'System Administrator' },
  { name: 'SC', description: 'Service Contract' },
  { name: 'SCH', description: 'Scheduling' },
  { name: 'SFC', description: 'Shop Floor Control / Job Order' },
  { name: 'SH', description: 'Shipping' },
  { name: 'Shipment', description: 'Shipment' },
  { name: 'SRO', description: 'Service Orders' },
  { name: 'System', description: 'System' },
  { name: 'Technical', description: 'Technical' },
  { name: 'TO', description: 'Transfer Order' },
  { name: 'Update UC1', description: 'Update UC1' },
  { name: 'VCN', description: 'Vendor Connect' },
  { name: 'Vendors', description: 'Vendors' },
  { name: 'VMI', description: 'Vendor Management' }
];

async function seedModules() {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    // Clear existing modules first (Optional: we might want to keep tickets intact, but if tickets reference old module names, it might fail if we delete modules. However, module name is just a VARCHAR in tickets, it's not a foreign key! Let's check schema.sql to be sure).
    // Actually, let's just UPSERT (INSERT ON CONFLICT DO UPDATE).
    
    for (const mod of modules) {
      await client.query(
        `INSERT INTO modules (name, description) 
         VALUES ($1, $2) 
         ON CONFLICT (name) 
         DO UPDATE SET description = EXCLUDED.description;`,
        [mod.name, mod.description]
      );
    }

    await client.query('COMMIT');
    console.log(`Successfully seeded ${modules.length} modules!`);
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error seeding modules:', error);
  } finally {
    client.release();
    pool.end();
  }
}

seedModules();
