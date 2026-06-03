import dotenv from 'dotenv';
dotenv.config();

import { sendTicketCreatedEmail } from './src/services/emailService.js';

async function testSend() {
  const mockTicket = {
    id: 9999,
    ticket_number: 'TEST-2026-0001',
    title: 'ทดสอบส่งเมลหาผู้ดูแลระบบ (Admin Email Send Test)',
    category: 'Technical',
    module: 'ALL',
    program_type: 'Standard',
    issue_type: 'Technical',
    form_name: 'test_send_admin.js',
    priority: 'high',
    description: 'รายละเอียดสำหรับการทดสอบระบบแจ้งเตือนทางอีเมลถึงผู้ดูแลระบบและเจ้าหน้าที่',
  };

  const customerEmail = 'supachai.athan@live.com';
  const adminEmails = ['supachai.athan@gmail.com', 'supachai.a@ppcc.co.th'];
  const ccEmail = 'additional.test@ppcc.co.th';

  console.log('Sending test ticket created email...');
  console.log('Customer:', customerEmail);
  console.log('Admins:', adminEmails);
  console.log('CC:', ccEmail);

  try {
    const info = await sendTicketCreatedEmail(mockTicket, customerEmail, adminEmails, ccEmail);
    console.log('Success! Info:', info);
  } catch (error) {
    console.error('Failed to send:', error);
  }
}

testSend();
