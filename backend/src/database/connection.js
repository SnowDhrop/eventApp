import Sequelize from "sequelize";
import * as dotenv from "dotenv";

dotenv.config();

const host = process.env.HOST;
const dbName = process.env.DATABASE;
const dbUser = process.env.DBUSER;
const dbMdp = process.env.DBMDP;

//  Connection to database
export const sequelize = new Sequelize("eventapp", dbUser, dbMdp, {
	host: host,
	dialect: "mysql",
	operatorsAliases: false,
	operatorsAliases: 0,
});

global.sequelize = sequelize;

// Associations
import User from "../models/User.js";

//  One-to-Many v.2
