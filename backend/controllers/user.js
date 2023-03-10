import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import jwt from "jsonwebtoken";
import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";
import dotenv from "dotenv";

const User = sequelize.models.user;

dotenv.config();

export const signupCtrl = (req, res, next) => {
	//VALIDATORS
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	req.body.is_admin = req.body.isAdmin;

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
					const token = jwt.sign({ email: req.body.email });
					//          Création de l'utilisateur
					User.create({
						...req.body,
						password: hash,
					})
						.then(() => res.status(201).json({ message: "User added" }))
						.catch((err) => res.status(400).json({ err }));
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

	User.findOne({
		where: { email: req.body.email },
	})
		.then((user) => {
			//          If user not found
			if (!user) {
				return res.status(401).json({ message: "User not found" });
			}

			//	 If user haven't confirm his email

			if (user.status === "pending") {
				console.log("En attente de confirmation");
				// res
				// 	.status(401)
				// 	.json({ error: "Pending account. Please verify your email" });
			}

			//          Compare passwords
			bcrypt
				.compare(req.body.password, user.password)
				.then((valid) => {
					if (!valid) {
						return res.status(401).json({ message: "Wrong password" });
					}

					//                  Token creation
					res.status(200).json({
						// userId: user.id_user,
						// isAdmin: user.is_admin,
						token: jwt.sign({ userId: user.id_user }, process.env.JWTKEY, {
							expiresIn: "24h",
						}),
					});
				})
				.catch((err) => res.status(500).json({ err }));
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
		.then((user) => {
			if (user == null) {
				throw "User doesn't found";
			}
			res.status(200).json({ user });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const getAllCtrl = (req, res, next) => {
	User.findAll({
		attributes: ["pseudo"],
	})
		.then((user) => {
			if (user == null) {
				throw "Database empty";
			}
			res.status(200).json({ user });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const updateCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

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
					where: { id_user: req.params.id },
				}
			)
				.then(() => res.status(201).json({ message: "User updated" }))
				.catch((err) => res.status(400).json({ err }));
		})

		.catch((err) => res.status(500).json({ err }));
};

export const deleteCtrl = (req, res, next) => {
	User.destroy({
		where: { id_user: req.params.id },
	})
		.then(() => res.status(200).json({ message: "User deleted" }))
		.catch((err) => res.status(400).json({ message: "User can't be delete " }));
};

export const addPic = (req, res, next) => {};
