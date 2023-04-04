import sequelize from "../src/database/connection.js";
import dotenv from "dotenv";
import transport from "./../config/nodemailer.js";

dotenv.config();

const User = sequelize.models.user;

export const sendConfirmationEmail = (req, res, next) => {
	const code = req.confirmationCode.token;

	// For sending an email with your computer, you have to verify my microsoft account with your computer
	transport
		.sendMail({
			from: process.env.MAIL,
			to: req.confirmationCode.email,
			subject: "Confirmez votre compte --- NE PAS REPONDRE",
			html: ` <h1>Bonjour, veuillez confirmer votre compte</h1>
	        <h2>Hello ${req.confirmationCode.pseudo}</h2>
	        <p>Bonjour</p>
	        <a href=http://localhost:3000/user/confirm/${req.confirmationCode.token} target="_blank">Confirm your email</a>`,
		})
		.catch((err) => console.log(err));
};

export const confirmCodeCtrl = (req, res, next) => {
	if (req.params.code) {
		User.findOne({
			where: { confirmation_code: req.params.code },
		})
			.then((user) => {
				User.update(
					{ status: "active" },
					{ where: { confirmation_code: req.params.code } }
				)
					.then(() =>
						//prettier-ignore
						res.status(200).json({ message: "Congratulation. Your account is confirmed." })
					)
					.catch((err) => res.status(500).json({ err }));
			})
			.catch((err) => res.status(404).json({ error: "User not found" }));
	}
};
