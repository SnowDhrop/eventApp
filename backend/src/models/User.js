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
	},
	email: {
		type: Sequelize.STRING(255),
		allowNull: false,
		unique: true,
	},
	is_admin: {
		type: Sequelize.BOOLEAN,
	},
	password: {
		type: Sequelize.STRING(),
		allowNull: false,
	},
	age: {
		type: Sequelize.INTEGER,
		allowNull: false,
	},
	created_at: {
		type: Sequelize.DATE,
		allowNull: true,
	},
	updated_at: {
		type: Sequelize.DATE,
		allowNull: true,
	},
};

export default User;
