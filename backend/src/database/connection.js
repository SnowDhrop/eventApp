const Sequelize = require("sequelize");

//  Connection to database
const sequelize = new Sequelize("eventapp", "root", "", {
	host: "127.0.0.1",
	dialect: "mysql",
	operatorsAliases: false,
	operatorsAliases: 0,
});

module.exports = sequelize;
global.sequelize = sequelize;

// Associations
const User = require("../models/User");

//  One-to-Many v.2
