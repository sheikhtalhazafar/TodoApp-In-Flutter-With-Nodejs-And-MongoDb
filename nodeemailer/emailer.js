const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
    host: 'smtp.ethereal.email',
    port: 587,
    auth: {
        user: 'kacie94@ethereal.email',
        pass: '8cfPqGhHBw54XXtFTA'
    }
});
async function sendOtpEmail(toEmail, otp) {
  const mailOptions = {
    from: `"TODO APP" <Todo@gmail.com>`,
    to: toEmail,
    subject: 'Your OTP Verification Code',
    html: `
      <h2>OTP Verification</h2>
      <p>Your OTP is:</p>
      <h1>${otp}</h1>
      <p>This OTP will expire in 5 minutes.</p>
    `
  };

  await transporter.sendMail(mailOptions);
}

module.exports = sendOtpEmail;
