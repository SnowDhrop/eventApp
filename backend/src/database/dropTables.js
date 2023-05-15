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
	logging: console.log,
});

async function supprimerToutesLesTables() {
	try {
		sequelize
			.sync({ force: true }) // create the database table for our model(s)

			.then(function () {
				console.log("YOLO");
			})
			.catch((err) => console.log(err));
	} catch (err) {
		console.log(err);
	}
}

// Appeler la fonction de suppression des tables
supprimerToutesLesTables();
