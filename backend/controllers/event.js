import { validationResult, check } from "express-validator";
// import bcrypt from "bcrypt";
// import { use } from "bcrypt/promises.js";
import sequelize from "../src/database/connection.js";
// import { Op } from "sequelize";

const Event = sequelize.models.event;
const Users_Event = sequelize.models.users_event;

export const createCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	Event.create({
		...req.body,
		id_creator: req.auth.userId,
	})
		.then(() => res.status(201).json({ message: "Event added" }))
		.catch((err) => res.status(400).json({ err }));
};

export const getOneCtrl = (req, res, next) => {
	Event.findOne({
		where: { id_event: req.params.id },
		attributes: [
			"title",
			"description",
			"participants",
			"participants_max",
			"address",
			"start_event",
			"end_event",
			"private",
			"active",
		],
	})
		.then((user) => {
			if (user == null) {
				throw "Event doesn't found";
			} else if (user.active !== 1) {
				throw "Event not active";
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

export const subscribeCtrl = (req, res, next) => {
	Event.findOne({
		where: { id_event: req.params.id },
		attributes: ["active", "private"],
	})
		.then((user) => {
			// Créer un cas où l'event est privé et seul les amis du créateur de l'évent peuvent y accéder.
			if (user.active === false || user.private === true) {
				res.send
					.status(404)
					.json({ err: "This event is not active or private" });
			}

			Users_Event.create({
				id_user: req.auth.userId,
				id_event: req.params.id,
			})
				.then(() =>
					res
						.status(201)
						.json({ message: "You have subscribe to this event" })
				)
				.catch((err) => res.status(500).json({ err: "Server error" }));
		})
		.catch((err) => res.status(404).json({ err: "Event not found" }));

	// Je fais une requête pour vérifier que l'event est public et non complet en récupérant l'id de l'event dans l'url

	// Je crée une entrée dans la table de jointure users_events avec l'id de l'utilisateur stocké dans req.auth et l'id de l'event
};

export const updateCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	Event.update(
		{
			id_style: req.body.id_style,
			id_category: req.body.id_category,
			title: req.body.title,
			description: req.body.description,
			address: req.body.address,
			city: req.body.city,
			location: req.body.location,
			start_event: req.body.start_event,
			end_event: req.body.end_event,
			private: req.body.private,
			active: req.body.active,
		},
		{
			where: { id_event: req.params.id },
		}
	)
		.then(() => res.status(200).json({ message: "Event updated" }))
		.catch((err) =>
			res.status(503).json({ message: "Server error", error: err })
		);
};

export const deleteCtrl = (req, res, next) => {
	Event.destroy({
		where: { id_event: req.params.id },
	})
		.then(() => res.status(200).json({ message: "Event deleted" }))
		.catch((err) =>
			res
				.status(400)
				.json({ message: "Event can't be delete ", error: err })
		);
};
