import { Sequelize } from "sequelize";

const Pic = {
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
		type: Sequelize.STRING(255),
		allowNull: false,
		defaultValue: "private",
	},
};

export default Pic;
