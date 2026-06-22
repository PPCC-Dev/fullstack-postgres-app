import dotenv from 'dotenv';
dotenv.config();

import nodemailer from 'nodemailer';

const testSimpleEmail = async () => {
  console.log('Testing SMTP connection (Plain Text)...');
  
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: parseInt(process.env.SMTP_PORT) || 587,
    secure: false, // true for 465, false for other ports
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });

  try {
    const adminEmail = 'supachai.a@ppcc.co.th';
    const info = await transporter.sendMail({
      from: process.env.SMTP_FROM || process.env.SMTP_USER,
      to: adminEmail,
      subject: 'Test Email Delivery (Plain Text)',
      text: 'Hello! This is a simple test email without any links to see if it bypasses spam filters.',
    });
    console.log('\n✅ Simple Test Email Sent Successfully!');
    console.log('Message ID:', info.messageId);
  } catch (error) {
    console.error('\n❌ Failed to send simple email:', error.message);
  } finally {
    process.exit();
  }
};

testSimpleEmail();
