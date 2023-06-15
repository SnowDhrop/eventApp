import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Users_Style = sequelize.define("users_styles", {
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
	id_style: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "style",
			key: "id_style",
		},
	},
});

export default Users_Style;
