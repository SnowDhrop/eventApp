import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Challenge = sequelize.define("challenge", {
	id_challenge: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	name: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	experienced_value: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
	},
});

export default Challenge;
