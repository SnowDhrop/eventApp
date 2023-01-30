import Sequelize from "sequelize";
const sequelize = new Sequelize("sqlite::memory:");

const User = sequelize.define("User", {
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
		type: Sequelize.STRING(300),
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
});

sequelize
	.sync()
	.then(() => {
		console.log("Tables created successfully!");
	})
	.catch((error) => {
		console.error("Unable to create tables : ", error);
	});

export default User;
