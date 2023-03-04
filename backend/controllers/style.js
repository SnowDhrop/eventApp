import sequelize from "../src/database/connection.js";

const Style = sequelize.models.style;

export const createCtrl = (req, res, next) => {
	Style.create({
		name: req.body.name,
	})
		.then(() => res.status(200).json({ message: "Style added" }))
		.catch((err) =>
			res.status(500).json({ message: "Server error", error: err })
		);
};
