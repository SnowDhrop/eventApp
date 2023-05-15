import { validationResult, check } from "express-validator";
// import bcrypt from "bcrypt";
// import { use } from "bcrypt/promises.js";
import sequelize from "../src/database/connection.js";
// import { Op } from "sequelize";

const Event = sequelize.models.event;
const Subscribe = sequelize.models.subscribe;
const Favorites = sequelize.models.favorites;
const User = sequelize.models.user;

// Rajouter la possibilité de spécifier des utilisateurs qui peuvent s'inscrire aux events privés
// Filtre pour les events par catégorie et/ou style et/ou favoris et/ou inscris

// Pouvoir compter le nombre d'utilisateurs inscris et les ajouter au nombre de participants

// Rajouter un cas d'utilisation: si l'utilisateur a créé l'évènement, l'inscrit automatiquement à l'event
// et il ne peut pas s'y désinscrire

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
			"id_event",
			"id_style",
			"id_category",
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
			"createdAt",
			"updatedAt",
		],
		include: [
			{
				model: User,
				as: "Subscribe",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
			{
				model: User,
				as: "Favorites",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
		],
	})
		.then((event) => {
			if (event == null) throw "Event not found";

			if (event.active === "inactive" || event.private === "private")
				return res
					.status(403)
					.json({ message: "This event is private or inactive" });

			event.id_creator === req.auth.userId
				? (event.id_creator = "You have create this event")
				: false;

			checkIFavoritesOrSubscribe(event, Subscribe);
			checkIFavoritesOrSubscribe(event, Favorites);

			res.status(200).json({ event });
		})
		.catch((err) =>
			res.status(400).json({ message: "Event not found", err: err })
		);
};

export const getAllCtrl = (req, res, next) => {
	Event.findAll({
		attributes: [
			"id_event",
			"id_style",
			"id_category",
			"title",
			"description",
			"participants",
			"participants_max",
			"address",
			"city",
			"location",
			"start_event",
			"end_event",
			"private",
			"active",
			"id_creator",
		],
		include: [
			{
				model: User,
				as: "Subscribe",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
			{
				model: User,
				as: "Favorites",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
		],
	})
		.then((events) => {
			if (events == null) {
				throw "There is not event";
			}

			const eventsPublicActive = events.filter(
				(event) => event.private !== "private" && event.active !== "inactive"
			);

			eventsPublicActive.map((event) => {
				event.id_creator === req.auth.userId
					? (event.id_creator = "You have create this event")
					: "";

				checkIFavoritesOrSubscribe(event, Subscribe);
				checkIFavoritesOrSubscribe(event, Favorites);
			});

			res.status(200).json({ eventsPublicActive });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const getMyEventsCtrl = (req, res, next) => {
	Event.findAll({
		attributes: [
			"id_event",
			"id_style",
			"id_category",
			"title",
			"description",
			"participants",
			"participants_max",
			"address",
			"city",
			"location",
			"start_event",
			"end_event",
			"private",
			"active",
			"id_creator",
		],
		include: [
			{
				model: User,
				as: "Subscribe",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
			{
				model: User,
				as: "Favorites",
				attributes: ["id_user"],
				through: { attributes: [] },
				where: { id_user: req.auth.userId },
				required: false,
			},
		],
	})
		.then((events) => {
			if (events == null) {
				throw "There is not event";
			}

			const eventsPublicActive = events.filter(
				(event) => event.id_creator === req.auth.userId
			);

			eventsPublicActive.map((event) => {
				checkIFavoritesOrSubscribe(event, Subscribe);
				checkIFavoritesOrSubscribe(event, Favorites);
			});

			res.status(200).json({ eventsPublicActive });
		})
		.catch((err) => res.status(400).json({ err }));
};

export const subscribeCtrl = (req, res, next) => {
	//Same logic of favorites
	Subscribe.destroy({
		where: { id_event: req.params.id, id_user: req.auth.userId },
	})
		.then((deletion) => {
			if (deletion === 1) {
				return res.status(200).json({
					message: "You are not subscribed to this event anymore",
				});
			}

			// Verify if the event exist and if he's inactive or private, send a 401 message, otherwise create a relation
			Event.findOne({
				where: { id_event: req.params.id },
				attributes: ["active", "private"],
			})
				.then((event) => {
					if (event.active === "inactive" || event.private === "private") {
						throw "This event is private or inactive";
					}

					if (event.participants === event.participants_max) {
						throw "The number of participants is reached";
					}

					Subscribe.create({
						id_user: req.auth.userId,
						id_event: req.params.id,
					})
						.then(() =>
							res.status(201).json({
								message: "You have subscribe to this event",
							})
						)
						.catch((err) =>
							res.status(500).json({ message: "Server error", error: err })
						);
				})
				.catch((err) => {
					let message = {};

					err.length > 0
						? (message = { error: err })
						: (message = { message: "Event not found" });

					res.status(404).json({ message });
				});
		})
		.catch((err) =>
			res.status(500).json({
				message: "Can't unsubscribe of this event",
				error: err,
			})
		);
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
					if (event.active === "inactive" || event.private === "private") {
						throw "This event is private or inactive";
					}

					Favorites.create({
						id_user: req.auth.userId,
						id_event: req.params.id,
					})
						.then(() =>
							res.status(201).json({
								message: "You added this event to your favorites",
							})
						)
						.catch((err) =>
							res.status(500).json({ message: "Server error", error: err })
						);
				})
				.catch((err) => {
					let message = {};

					err.length > 0
						? (message = { error: err })
						: (message = { message: "Event not found" });

					res.status(404).json({ message });
				});
		})
		.catch((err) =>
			res.status(500).json({
				message: "Can't discard this event of your favorites",
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
			res.status(400).json({ message: "Event can't be delete ", error: err })
		);
};

const checkIFavoritesOrSubscribe = (event, admission) => {
	let data = "";
	let key = "";

	admission === Subscribe
		? ((data = event.Subscribe), (key = "Subscribe"))
		: ((data = event.Favorites), (key = "Favorites"));

	data.length > 0
		? event.setDataValue(key, true)
		: event.setDataValue(key, false);
};
