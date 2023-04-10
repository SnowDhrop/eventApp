import { validationResult, check } from "express-validator";
// import bcrypt from "bcrypt";
// import { use } from "bcrypt/promises.js";
import sequelize from "../src/database/connection.js";
// import { Op } from "sequelize";

const Event = sequelize.models.event;
const Subscribe = sequelize.models.subscribe;
const Favorites = sequelize.models.favorites;

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
			"id_creator",
		],
	})
		.then((event) => {
			if (event == null || event.active === "inactive") {
				throw "Event not found or inactive";
			}

			if (event.id_creator === req.auth.userId) {
				event.id_creator = "You have create this event";
			}
			res.status(200).json({ event });
		})
		.catch((err) =>
			res.status(400).json({ message: "Event not found", err: err })
		);
};

export const getAllCtrl = (req, res, next) => {
	Event.findAll({
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
			"id_creator",
		],
	})
		.then((events) => {
			if (events == null) {
				throw "Database empty";
			}

			const eventsPublicActive = events.filter(
				(event) => event.private === "public"
			);

			eventsPublicActive.map((event) => {
				if (event.id_creator === req.auth.userId) {
					event.id_creator = "You have create this event";
				}
			});

			res.status(200).json({ eventsPublicActive });
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
			if (user.active === "inactive" || user.private === "private") {
				res.status(404).json({
					err: "This event is private or not active",
				});
			}

			Subscribe.create({
				id_user: req.auth.userId,
				id_event: req.params.id,
			})
				.then(() =>
					res
						.status(201)
						.json({ message: "You have subscribe to this event" })
				)
				.catch((err) =>
					res.status(500).json({
						err: "You have already subscribe to this event",
					})
				);
		})
		.catch((err) => res.status(404).json({ err: "Event not found" }));

	// Je fais une requête pour vérifier que l'event est public et non complet en récupérant l'id de l'event dans l'url

	// Je crée une entrée dans la table de jointure subscribe avec l'id de l'utilisateur stocké dans req.auth et l'id de l'event
};

export const favoritesCtrl = (req, res, next) => {
	// if the event is found with id_event and user_id, delete it
	Favorites.destroy({
		where: { id_event: req.params.id, id_user: req.auth.userId },
	})
		.then((deletion) => {
			if (deletion === 1) {
				return res.status(200).json({
					message: "This event is not in your favorites anymore",
				});
			}

			// Verify if the event exist and if he's inactive or private, send a 401 message, otherwise create a relation
			Event.findOne({
				where: { id_event: req.params.id },
				attributes: ["active", "private"],
			})
				.then((event) => {
					if (
						event.active === "inactive" ||
						event.private === "private"
					) {
						res.status(401).json({
							message: "This event is private or inactive",
						});
					}

					Favorites.create({
						id_user: req.auth.userId,
						id_event: req.params.id,
					})
						.then(() =>
							res.status(201).json({
								message:
									"You added this event to your favorites",
							})
						)
						.catch((err) =>
							res
								.status(500)
								.json({ message: "Server error", error: err })
						);
				})
				.catch((err) =>
					res
						.status(404)
						.json({ message: "Event not found", error: err })
				);
		})
		.catch((err) =>
			res.status(500).json({
				message: "Deletion of the event don't works",
				error: err,
			})
		);
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
