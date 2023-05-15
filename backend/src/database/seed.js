import sequelize from "./connection.js";
import Category from "../models/Category.js";

//Initial datas
import categories from "../initial/categories.js";

sequelize
	.sync({ force: false })
	// Truncate tables
	.then(() => {
		Category.destroy({ where: {} });
	})

	// Add initial datas
	.then(() => {
		// A faire pour les artistes/styles
		// for (let category of categories) {
		// 	Category.upsert(category);
		// }

		Category.bulkCreate(categories);

		return console.log("Database is filled");
	})
	.catch((error) => {
		console.error("Unable to create tables: ", error);
	});
