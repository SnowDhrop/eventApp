import Sequelize from "sequelize";
import dotenv from "dotenv";
import User from "../models/User.js";

dotenv.config();

const host = process.env.HOST;
const dbName = process.env.DATABASE;
const dbUser = process.env.DBUSER;
const dbMdp = process.env.DBMDP;
const dialect = process.env.DIALECT;

export const sequelize = new Sequelize(dbName, dbUser, dbMdp, {
	host: host,
	dialect: dialect,
	pool: {
		max: 5,
		min: 0,
		idle: 10000,
	},
	logging: false,
});

const UserModel = User(sequelize);

sequelize
	.authenticate()
	.then(() => {
		console.log("Connection has been established successfully.");

		UserModel.sync({ force: false })
			.then(() => {
				console.log("Tables created successfully!");
			})
			.catch((error) => {
				console.error("Unable to create tables : ", error);
			});
	})
	.catch((err) => {
		console.error("Unable to connect to the database:", err);
	});
