import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import jwt from "jsonwebtoken";
import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";
import dotenv from "dotenv";
import transport from "./../config/nodemailer.js";

const User = sequelize.models.user;

dotenv.config();

// lancer scrapping pour recupp allArtists/styles
// Rajouter données initiales de style de musique
// Rajouter données initiales d'artistes
// Créer un nouveau script qui rajoute les nouveaux styles/artistes à la base avec upsert

// - associer artistes et genrs préférés à l'utilisateur
// - pouvoir les modifier

export const signupCtrl = (req, res, next) => {
	//VALIDATORS
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		6;
		return res.status(422).json({ errors: errors.array() });
	}

	req.body.is_admin = req.body.isAdmin;

	User.findOne({
		where: {
			// Search by user or pseudo
			[Op.or]: [
				{
					email: req.body.email,
				},
				{
					pseudo: req.body.pseudo,
				},
			],
		},
	})
		.then((userFound) => {
			if (userFound) {
				return (
					res
						.status(401)
						// Message volontairement flou pour diminuer brute forçing
						.json({ message: "Email or pseudo already registered" })
				);
			}

			//   Hachage du mdp
			bcrypt
				.hash(req.body.password, 10)
				.then((hash) => {
					// Create confirmation code
					const email = req.body.email;
					const pseudo = req.body.pseudo;

					const token = jwt.sign({ email: email }, process.env.JWTKEY1);

					req.confirmationCode = { token, email, pseudo };

					//          Création de l'utilisateur
					User.create({
						...req.body,
						password: hash,
						confirmation_code: token,
					})
						.then(() => {
							res.status(201).json({ message: "User added" });
						})
						.catch((err) => res.status(400).json({ err }));
					next();
				})

				.catch((err) => res.status(500).json({ err }));
		})
		.catch((err) => res.status(500).json({ err }));
};

export const loginCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	//	 If user haven't confirm his email
	const checkConfirmationEmail = (user) => {
		if (user.status === "pending") {
			console.log("En attente de confirmation", user.confirmation_code);
			const error = new Error("Pending account. Please verify your email");
			error.status = 401;
			throw error;
		}
	};

	User.findOne({
		where: { email: req.body.email },
	})
		.then((user) => {
			//          If user not found
			if (!user) {
				return res.status(401).json({ message: "User not found" });
			}

			//          Compare passwords
			bcrypt
				.compare(req.body.password, user.password)
				.then((valid) => {
					if (!valid) {
						return res.status(401).json({ message: "Wrong password" });
					}

					checkConfirmationEmail(user);

					//                  Token creation
					res.status(200).json({
						// userId: user.id_user,
						// isAdmin: user.is_admin,
						token: jwt.sign({ userId: user.id_user }, process.env.JWTKEY2, {
							expiresIn: "24h",
						}),
					});
				})
				.catch((err) => {
					res.status(err.status || 500).json({
						error: err.message || err,
					});
				});
		})
		.catch((err) => res.status(500).json({ err }));
};

export const getOneCtrl = (req, res, next) => {
	let whereClause = "";

	if (req.params.param.includes("@")) {
		whereClause = { email: req.params.param };
	} else if (!parseInt(req.params.param)) {
		whereClause = { pseudo: req.params.param };
	} else {
		whereClause = { id_user: req.params.param };
	}

	User.findOne({
		where: whereClause,
		attributes: ["pseudo", "email", "birthday", "createdAt", "updatedAt"],
	})
		.then((users) => {
			if (users == null) {
				throw "User not found";
			}

			req.users = { users };

			next();
			// res.status(200).json({ user });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const getAllCtrl = (req, res, next) => {
	User.findAll({
		attributes: ["id_user", "pseudo", "birthday", "createdAt"],
	})
		.then((users) => {
			if (users == null) {
				throw "Server error";
			}

			req.users = { users };
			next();
		})
		.catch((err) => res.status(400).json({ err }));
};

export const updateCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	} else {
		bcrypt
			.hash(req.body.password, 10)
			.then((hash) => {
				//          Création de l'utilisateur
				User.update(
					{
						pseudo: req.body.pseudo,
						email: req.body.email,
						password: hash,
					},
					{
						where: { id_user: req.auth.userId },
					}
				)
					.then(() => res.status(201).json({ message: "User updated" }))
					.catch((err) => res.status(400).json({ err }));
			})

			.catch((err) => res.status(500).json({ err }));
	}
};

export const deleteCtrl = (req, res, next) => {
	User.destroy({
		where: { id_user: req.params.id },
	})
		.then(() => res.status(200).json({ message: "User deleted" }))
		.catch((err) => res.status(400).json({ message: "User can't be delete " }));
};

export const changePassRequest = (req, res, next) => {
	const token = jwt.sign({ email: req.user.email }, process.env.JWTKEY1);

	User.update(
		{ password_code: token },
		{
			where: { email: req.user.email },
		}
	)
		.then(() => {
			req.changePass = { token };

			res.status(200).json({
				message: "Password Code added",
			});
			next();
		})
		.catch((err) => res.status(500).json({ err }));
};

export const associateArtists = (req, res, next) => {
	console.log("YOLO");
	res.send("YOLO");
};
