import { Sequelize } from "sequelize";

const User = {
	id: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
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
		type: Sequelize.BOOLEAN,
		defaultValue: false,
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
};

export default User;
