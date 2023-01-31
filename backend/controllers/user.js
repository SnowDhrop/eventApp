import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import jwt from "jsonwebtoken";
import User from "../src/models/User.js";
import sequelize from "../src/database/connection.js";

export const signupCtrl = (req, res, next) => {
	//VALIDATORS
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	const User = sequelize.models.user;

	User.findOne({
		where: { email: req.body.email },
	})
		.then((userFound) => {
			if (userFound) {
				return res
					.status(401)
					.json({ message: "User already registered" });
			}

			//   Hachage du mdp
			bcrypt
				.hash(req.body.password, 10)
				.then((hash) => {
					//          Création de l'utilisateur
					User.create({
						...req.body,
						password: hash,
					})
						.then(() =>
							res.status(201).json({ message: "User added" })
						)
						.catch((err) => res.status(400).json({ err }));
				})

				.catch((err) => res.status(500).json({ err }));
		})
		.catch((err) => res.status(500).json({ err }));

	// User.create({
	// 	...req.body,
	// })
	// 	.then(() => res.status(201).json({ message: "User added" }))
	// 	.catch((err) => res.status(400).json({ err }));
};

export const loginCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	const User = sequelize.models.user;

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
						return res
							.status(401)
							.json({ message: "Wrong password" });
					}

					console.log(user);

					//                  Token creation
					res.status(200).json({
						userId: user.id,
						isAdmin: user.isAdmin,
						token: jwt.sign({ userId: user.id }, "FIND_IT", {
							expiresIn: "24h",
						}),
					});
				})
				.catch((err) => res.status(500).json({ err }));
		})
		.catch((err) => res.status(500).json({ err }));
};

export const getOneCtrl = (req, res, next) => {
	const User = sequelize.models.user;

	User.findOne({
		where: { id: req.params.id },
		attributes: ["pseudo", "email", "age", "createdAt", "updatedAt"],
	})
		.then((user) => {
			if (user == null) {
				throw "User doesn't found";
			}
			res.status(200).json({ user });
		})
		.catch((err) => res.status(400).json({ err }));
};
