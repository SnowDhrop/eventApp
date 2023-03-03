import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Users_Challenge = sequelize.define("users_challenges", {
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
	id_challenge: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "challenges",
			key: "id_challenge",
		},
	},
});

export default Users_Challenge;
