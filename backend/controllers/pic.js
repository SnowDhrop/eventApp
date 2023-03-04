import sequelize from "../src/database/connection.js";

const Pic = sequelize.models.pic;

export const createCtrl = (req, res, next) => {
	Pic.create({
		name: req.body.name,
		status: req.body.status,
	})
		.then(() => res.status(200).json({ message: "Pic created" }))
		.catch((err) =>
			res.status(500).json({ message: "Server error", error: err })
		);
};
