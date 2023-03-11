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

const confirmationEmail = (req, res, next) => {
	const code = req.confirmationCode.token;

	transport
		.sendMail({
			from: process.env.MAIL,
			to: req.confirmationCode.email,
			subject: "Please confirm your account",
			html: ` <h1>Email confirmation</h1>
            <h2>Hello ${req.confirmationCode.pseudo}</h2>   
            <p>Bien joué frère 😉 BOUYAAAAAAAAA</p>`,
		})
		.catch((err) => console.log(err));
};

export default confirmationEmail;
