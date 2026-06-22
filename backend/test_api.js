import jwt from 'jsonwebtoken';
import dotenv from 'dotenv';
dotenv.config();

async function run() {
  try {
    const token = jwt.sign({ id: 1, role: 'admin' }, process.env.JWT_SECRET || 'supersecretkeyforapexsupportdesk2026!');
    const res = await fetch('http://localhost:5001/api/reports/summary?filter=all&custNum=all', {
      headers: { 'Authorization': `Bearer ${token}` }
    });
    const text = await res.text();
    console.log('Status:', res.status);
    console.log('Body:', text.substring(0, 200));
  } catch(e) {
    console.error(e);
  }
}
run();
