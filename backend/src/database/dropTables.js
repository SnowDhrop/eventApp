import Sequelize, { Model } from "sequelize";
import dotenv from "dotenv";

import Favorites from "./../models/Favorites.js";
import Subscribe from "./../models/Subscribe.js";
import Category from "./../models/Category.js";
import Challenge from "./../models/Challenge.js";
import Event from "./../models/Event.js";
import Mascotte from "./../models/Mascotte.js";
import Pic from "./../models/Pic.js";
import Social from "./../models/Social.js";
import Style from "./../models/Style.js";
import User from "./../models/User.js";
import Users_Challenge from "./../models/Users_Challenge.js";

dotenv.config();

const { HOST, DATABASE, DBUSER, DBMDP, DIALECT } = process.env;

const models = [
	Favorites,
	Subscribe,
	Event,
	Style,
	Category,
	Users_Challenge,
	Challenge,
	Mascotte,
	Pic,
	Social,
	User,
];

// Créer une nouvelle instance de Sequelize
const sequelize = new Sequelize(DATABASE, DBUSER, DBMDP, {
	host: HOST,
	dialect: DIALECT,
	pool: {
		max: 5,
		min: 0,
		idle: 10000,
	},
	logging: false,
});

sequelize
	.authenticate()
	.then(async () => {
		await sequelize.query("SET FOREIGN_KEY_CHECKS = 0", { raw: true });

		for (let i = 0; i < models.length; i++) {
			await models[i].drop({ force: true });
		}
		await sequelize.query("SET FOREIGN_KEY_CHECKS = 1", { raw: true });
	})
	.then(() => {
		console.log("Table dropped");
	})
	.catch((err) => {
		console.error("Unable to connect to the database:", err);
	});
