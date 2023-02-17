import { Sequelize } from "sequelize";

const Event = {
	id_event: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
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
	participants: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		defaultValue: 0,
	},
	address: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	city: {
		type: Sequelize.STRING(255),
		allowNull: false,
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
};

export default Event;
