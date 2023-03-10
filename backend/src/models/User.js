import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const User = sequelize.define("user", {
	id_user: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	id_pic: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "pics",
			key: "id_pic",
		},
		defaultValue: 1,
	},
	pseudo: {
		type: Sequelize.STRING(50),
		allowNull: false,
		unique: true,
	},
	email: {
		type: Sequelize.STRING(255),
		allowNull: false,
		unique: true,
	},
	is_admin: {
		type: Sequelize.ENUM("admin", "normal"),
		defaultValue: "normal",
		allowNull: false,
	},
	password: {
		type: Sequelize.STRING(),
		allowNull: false,
	},
	birthday: {
		type: Sequelize.DATEONLY,
		allowNull: false,
	},
	status: {
		type: Sequelize.ENUM("pending", "active"),
		defaultValue: "pending",
	},
	confirmation_code: {
		type: Sequelize.STRING(),
		unique: true,
	},
});

export default User;
