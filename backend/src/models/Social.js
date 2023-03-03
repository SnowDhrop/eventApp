import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Social = sequelize.define("social", {
	id_user_one: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "users",
			key: "id_user",
		},
	},
	id_user_two: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "users",
			key: "id_user",
		},
	},
	status: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
});

export default Social;
