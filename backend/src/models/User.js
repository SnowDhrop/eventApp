import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const User = sequelize.define(
	"user",
	{
		id_user: {
			type: Sequelize.INTEGER(11),
			allowNull: false,
			autoIncrement: true,
			primaryKey: true,
		},
		default_pic: {
			type: Sequelize.BOOLEAN,
			allowNull: false,
			defaultValue: true,
		},
		pseudo: {
			type: Sequelize.STRING(50),
			allowNull: false,
		},
		email: {
			type: Sequelize.STRING(255),
			allowNull: false,
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
			allowNull: false,
		},
		password_code: {
			type: Sequelize.STRING(),
		},
	},
	{
		indexes: [
			{ unique: true, fields: ["pseudo"] },
			{ unique: true, fields: ["email"] },
			{ unique: true, fields: ["confirmation_code"] },
			{ unique: true, fields: ["password_code"] },
		],
	}
);

export default User;
