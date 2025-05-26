const functions = require('firebase-functions');
const nodemailer = require('nodemailer');
require('dotenv').config();
// Configure your Gmail account here
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER,               // Your Gmail address
    pass: process.env.EMAIL_PASS,                   // Gmail App Password (see notes below)
  }
});

// Callable Cloud Function to send email
exports.sendEmail = functions.https.onCall(async (data, context) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: data.to,             // Recipient email passed from Flutter
    subject: data.subject,   // Subject passed from Flutter
    text: data.message       // Message passed from Flutter
  };

  try {
    await transporter.sendMail(mailOptions);
    return { success: true };
  } catch (error) {
    return { success: false, error: error.toString() };
  }
});
