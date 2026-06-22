import { getSummaryReport } from './src/controllers/reportController.js';
import pool from './src/config/db.js';
import dotenv from 'dotenv';
dotenv.config();

const req = { query: { filter: 'weekly', custNum: 'all' } };
const res = { 
  status: (code) => ({ json: (data) => console.log('Status', code, data) }),
  json: (data) => console.log('Success')
};

getSummaryReport(req, res).then(() => process.exit());
