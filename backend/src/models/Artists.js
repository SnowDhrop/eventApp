import { Sequelize } from "sequelize";
import sequelize from "../database/connection.js";

const Artist = sequelize.define("artist", {
	id_artist: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		autoIncrement: true,
		primaryKey: true,
	},
	id_style: {
		type: Sequelize.INTEGER(11),
		allowNull: false,
		references: {
			model: "styles",
			key: "id_style",
		},
	},
	name: {
		type: Sequelize.STRING(255),
		allowNull: false,
	},
});

export default Artist;
