import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Subscribe = sequelize.define("subscribe", {
	id: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	id_user: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "users",
			key: "id_user",
		},
	},
	id_event: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "events",
			key: "id_event",
		},
	},
});

export default Subscribe;
