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

	User.create({
		...req.body,
	})
		.then(() => res.status(201).json({ message: "User added" }))
		.catch((err) => res.status(400).json({ err }));
	// res.json(users);

	// res.status(201).json({ pouet: req.body });

	//HACHAGE

	//          Création de l'utilisateur
	// User
	// 	.create({
	// 		pseudo: "yolo",
	// 	})
	// 	.then(() => res.status(201).json({ message: "User added" }))
	// 	.catch((err) => res.status(400).json({ err }));
};
