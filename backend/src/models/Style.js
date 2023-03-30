import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Style = sequelize.define(
	"style",
	{
		id_style: {
			type: Sequelize.INTEGER(11),
			allowNull: false,
			autoIncrement: true,
			primaryKey: true,
		},
		name: {
			type: Sequelize.STRING(255),
			allowNull: false,
		},
	},
	{
		indexes: [{ unique: true, fields: ["name"] }],
	}
);

export default Style;
