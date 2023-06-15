import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Users_Artist = sequelize.define("users_artists", {
	id: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	id_user: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "users",
			key: "id_user",
		},
	},
	id_artist: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "artists",
			key: "id_artist",
		},
	},
});

export default Users_Artist;
