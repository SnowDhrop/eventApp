import sequelize from "./../src/database/connection.js";

const Category = sequelize.models.category;

export const createCtrl = (req, res, next) => {
	Category.create({
		name: req.body.name,
	})
		.then(() => res.status(200).json({ message: "Category added" }))
		.catch((err) =>
			res.status(500).json({ message: "Server error", error: err })
		);
};
