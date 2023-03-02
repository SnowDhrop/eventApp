import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Social = sequelize.define("social", {
	//FOREIGN KEY
	id_user_one: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
	},
	//FOREIGN KEY
	id_user_two: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
	},
	status: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
});

export default Social;
