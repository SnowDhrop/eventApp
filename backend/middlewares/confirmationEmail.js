import sequelize from "../src/database/connection.js";
import dotenv from "dotenv";
import transport from "./../config/nodemailer.js";

dotenv.config();

const User = sequelize.models.user;

export const sendConfirmationEmail = (req, res, next) => {
	transport
		.sendMail({
			from: process.env.MAIL,
			to: req.confirmationCode.email,
			subject: "Please confirm your account",
			html: ` <h1>Email confirmation</h1>
            <h2>Hello ${req.confirmationCode.pseudo}</h2>   
            <p>Bien joué frère 😉 BOUYAAAAAAAAA</p>
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
