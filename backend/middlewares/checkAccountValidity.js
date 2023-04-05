import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";

const User = sequelize.models.user;

const checkAccountValidity = (req, res, next) => {
	console.log("YOLO");

	User.findOne({
		where: {
			// Recherche par email ou pseudo
			[Op.or]: [
				{
					email: req.body.email,
				},
				{
					pseudo: req.body.pseudo,
				},
			],
		},
		attributes: ["status", "email"],
	})
		.then((user) => {
			if (!user) {
				res.status(402).json({ error: "User not found" });
			} else {
				if (user.status === "pending") {
					res.status(401).json({
						error: "You have to confirm your account before",
					});
				} else {
					const email = user.email;
					req.user = { email };

					next();
				}
			}
		})
		.catch((err) =>
			res
				.status(404)
				.json({
					error: err,
					message: "Error while checking your account validity",
				})
		);
};

export default checkAccountValidity;
