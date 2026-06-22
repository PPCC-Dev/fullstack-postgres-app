import dotenv from 'dotenv';
dotenv.config();

import { sendTicketCreatedEmail, sendTicketClosedEmail } from './src/services/emailService.js';

const testTicketEmail = async () => {
  console.log('Testing Ticket Emails...');
  
  const dummyTicket = {
    id: 999,
    ticket_number: 'TCK-TEST-999',
    title: 'ทดสอบการยิงอีเมลเคสจากระบบ',
    module: 'HR',
    program_type: 'WEB',
    status: 'open',
    contact_name: 'คุณ สมชาย ทดสอบ',
    cust_num: 'CUST-001',
    description: 'นี่คือข้อความทดสอบเพื่อตรวจสอบหน้าตาของอีเมลแจ้งเตือนเมื่อเปิดเคสใหม่'
  };

  const adminEmail = 'supachai.a@ppcc.co.th';
  
  try {
    console.log('1. Sending Ticket Created Email...');
    // parameters: (ticket, customerEmail, adminEmails, ccEmail)
    // using adminEmail as the customer to see the output
    await sendTicketCreatedEmail(dummyTicket, adminEmail, [], '');
    console.log('✅ Ticket Created Email Sent!');
    
    console.log('\n2. Sending Ticket Closed Email...');
    // parameters: (ticket, toEmail, ccEmail)
    await sendTicketClosedEmail(dummyTicket, adminEmail, '');
    console.log('✅ Ticket Closed Email Sent!');
    
  } catch (error) {
    console.error('\n❌ Failed to send ticket email:', error.message);
  } finally {
    process.exit();
  }
};

testTicketEmail();
