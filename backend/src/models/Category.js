import { Sequelize } from "sequelize";

const Category = {
	id_category: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	name: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
};

export default Category;
