const Sequelize = require("sequelize");

module.exports = sequelize.define("User", {
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
});

sequelize
	.sync()
	.then(() => {
		console.log("Tables created successfully!");
	})
	.catch((error) => {
		console.error("Unable to create tables : ", error);
	});
