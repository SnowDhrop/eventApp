import Sequelize from "sequelize";
import dotenv from "dotenv";

dotenv.config();

const { HOST, DATABASE, DBUSER, DBMDP, DIALECT } = process.env;

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
	.then(() => {
		console.log("Be happy ! You are connected !");

		sequelize
			.sync({ force: false })
			.then(() => {
				console.log("Enjoy your tables bro'");
			})
			.catch((error) => {
				console.error("Unable to create tables : ", error);
			});
	})
	.catch((err) => {
		console.error("Unable to connect to the database:", err);
	});

export default sequelize;
