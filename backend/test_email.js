import dotenv from 'dotenv';
dotenv.config();

import { sendPasswordResetEmail } from './src/services/emailService.js';

const testEmail = async () => {
  console.log('Testing SMTP connection...');
  console.log('Host:', process.env.SMTP_HOST);
  console.log('User:', process.env.SMTP_USER);

  try {
    const adminEmail = 'supachai.a@ppcc.co.th';
    console.log('Sending test email to Admin:', adminEmail);
    const result = await sendPasswordResetEmail(adminEmail, 'http://localhost:5173/reset-password');
    console.log('\n✅ Test Email Sent Successfully!');
    console.log('Result:', result.response || 'Ethereal Test URL provided above');
  } catch (error) {
    console.error('\n❌ Failed to send email:', error.message);
  } finally {
    process.exit();
  }
};

testEmail();
