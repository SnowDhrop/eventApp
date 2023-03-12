import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config();

const transport = nodemailer.createTransport({
	service: process.env.MAILSERVICE,
	secure: false,
	auth: {
		user: process.env.MAIL,
		pass: process.env.MAILPASS,
	},
	tls: {
		rejectUnauthorized: false,
	},
});

export default transport;
