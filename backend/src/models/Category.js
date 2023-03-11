import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Category = sequelize.define(
	"category",
	{
		id_category: {
			type: Sequelize.INTEGER(11),
			allowNull: false,
			autoIncrement: true,
			primaryKey: true,
		},
		name: {
			type: Sequelize.STRING(255),
			allowNull: false,
			unique: true,
		},
	},
	{
		indexes: [{ unique: true, fields: ["name"] }],
	}
);

export default Category;
