import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Event = sequelize.define("event", {
	id_event: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	id_creator: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "users",
			key: "id_user",
		},
	},
	title: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	description: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	id_category: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		// FOREIGN KEY
	},
	id_style: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		// FOREIGN KEY
	},
	participants: {
		type: Sequelize.INTEGER(11),
		defaultValue: 0,
	},
	participants_max: {
		type: Sequelize.INTEGER(11),
	},
	address: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	city: {
		type: Sequelize.STRING(255),
		defaultValue: "Montpellier",
	},
	location: {
		type: Sequelize.STRING(255),
	},
	start_event: {
		type: Sequelize.DATE,
		allowNull: false,
	},
	end_event: {
		type: Sequelize.DATE,
		allowNull: false,
	},
	private: {
		type: Sequelize.BOOLEAN,
		allowNull: false,
	},
	active: {
		type: Sequelize.BOOLEAN,
		allowNull: false,
		defaultValue: 1,
	},
});

export default Event;
