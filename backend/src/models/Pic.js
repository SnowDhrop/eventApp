import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Pic = sequelize.define("pic", {
	id_pic: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	name: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
	status: {
		type: Sequelize.ENUM("private", "public"),
		allowNull: false,
		defaultValue: "private",
	},
});

export default Pic;
