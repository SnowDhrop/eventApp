import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config();

const transport = nodemailer.createTransport({
	service: "smtp.protonmail.com",
	auth: {
		user: process.env.MAIL,
		pass: process.env.MAILPASS,
	},
});
