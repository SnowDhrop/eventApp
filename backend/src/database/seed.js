import sequelize from "./connection.js";
import Category from "../models/Category.js";
import Artist from "../models/Artists.js";
import Style from "../models/Style.js";

//Initial datas
import categories from "../initial/categories.js";
import artists from "../initial/artists.js";
import styles from "../initial/styles.js";

sequelize
	.sync({ force: false })
	// Truncate tables
	.then(() => {
		Category.destroy({ where: {} });
	})

	// Add initial datas
	.then(() => {
		// A faire pour les artistes/styles
		for (let category of categories) {
			Category.upsert(category);
		}

		for (let style of styles) {
			Style.upsert(style);
		}

		for (let artist of artists) {
			Artist.upsert(artist);
		}

		Category.bulkCreate(categories);
		Style.bulkCreate(styles);
		Artist.bulkCreate(artists);

		return console.log("Database is filled");
	})
	.catch((error) => {
		console.error("Unable to create tables: ", error);
	});
