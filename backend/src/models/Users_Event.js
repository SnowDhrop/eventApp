import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Users_Event = sequelize.define("users_event", {
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
			model: "User",
			key: "id_user",
		},
	},
	id_event: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "Event",
			key: "id_event",
		},
	},
});

export default Users_Event;
