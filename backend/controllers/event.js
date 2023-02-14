import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";

export const createCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	const Event = sequelize.models.event;

	Event.create({
		...req.body,
	})
		.then(() => res.status(201).json({ message: "Event added" }))
		.catch((err) => res.status(400).json({ err }));
};

export const getOneCtrl = (req, res, next) => {};

export const getAllCtrl = (req, res, next) => {};
