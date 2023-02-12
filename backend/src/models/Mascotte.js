import { Sequelize } from "sequelize";

const Mascotte = {
	id_mascotte: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	//FOREIGN KEY
	id_user: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
	},
	experience: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		defaultValue: 0,
	},
	pic: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		defaultValue: 0,
	},
};

export default Mascotte;