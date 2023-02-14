import { Sequelize } from "sequelize";

const Styles = {
	id_style: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	name: {
		type: Sequelize.toString(255),
		allowNull: false,
		unique: true,
	},
};

export default Styles;
