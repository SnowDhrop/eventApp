import Sequelize from "sequelize";

class User extends Sequelize.Model {}

export default (sequelize) => {
	User.init(
		{
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
				allowNull: false,
			},
			updated_at: {
				type: Sequelize.DATE,
				allowNull: false,
			},
		},
		{ sequelize, modelName: "user" }
	);

	return User;
};
