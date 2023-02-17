import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";

const Event = sequelize.models.event;

export const createCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	Event.create({
		...req.body,
	})
		.then(() => res.status(201).json({ message: "Event added" }))
		.catch((err) => res.status(400).json({ err }));
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

	Event.findOne({
		where: whereClause,
		attributes: [
			"title",
			"description",
			"participants",
			"address",
			"start_event",
			"end_event",
		],
	})
		.then((user) => {
			if (user == null) {
				throw "Event doesn't found";
			}
			res.status(200).json({ user });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const getAllCtrl = (req, res, next) => {
	Event.findAll({
		attributes: [
			"title",
			"description",
			"participants",
			"address",
			"start_event",
			"end_event",
		],
	})
		.then((event) => {
			if (event == null) {
				throw "Database empty";
			}
			res.status(200).json({ event });
		})
		.catch((err) => res.status(400).json({ err }));
};
