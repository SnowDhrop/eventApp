import sequelize from "../database/connection.js";
import { Sequelize } from "sequelize";

import User from "./User.js";
import Event from "./Event.js";
import Category from "./Category.js";
import Challenge from "./Challenge.js";
import Mascotte from "./Mascotte.js";
import Pic from "./Pic.js";
import Social from "./Social.js";
import Style from "./Style.js";
import Subscribe from "./Subscribe.js";
import Users_Challenge from "./Users_Challenge.js";
import Favorites from "./Favorites.js";
import Artist from "./Artists.js";
import Users_Artist from "./Users_Artist.js";
import Users_Style from "./Users_Style.js";

// DEFINE FOREIGN KEYS
//Subscribe
User.belongsToMany(Event, {
	through: Subscribe,
	foreignKey: "id_user",
	unique: false,
	as: "Subscribe",
});
Event.belongsToMany(User, {
	through: Subscribe,
	foreignKey: "id_event",
	unique: false,
	as: "Subscribe",
});

//Favorites
User.belongsToMany(Event, {
	through: Favorites,
	foreignKey: "id_user",
	unique: false,
	as: "Favorites",
});
Event.belongsToMany(User, {
	through: Favorites,
	foreignKey: "id_event",
	unique: false,
	as: "Favorites",
});

//EVENT RELATIONS
// User who create an event
User.hasMany(Event, { foreignKey: "id_creator" });
Event.belongsTo(User, { foreignKey: "id_creator" });

// Relation between events and styles
Style.hasMany(Event, { foreignKey: "id_style" });
Event.belongsTo(Style, { foreignKey: "id_style" });

//Relation between events and categories
Category.hasMany(Event, { foreignKey: "id_category" });
Event.belongsTo(Category, { foreignKey: "id_category" });

//USER RELATIONS
//Users_Challenge
User.belongsToMany(Challenge, {
	through: Users_Challenge,
	foreignKey: "id_user",
	unique: false,
});
Challenge.belongsToMany(User, {
	through: Users_Challenge,
	foreignKey: "id_challenge",
	unique: false,
});

// PREFERENCES USER RELATIONS
Style.hasMany(Artist, { foreignKey: "id_style" });
Artist.belongsTo(Style, { foreignKey: "id_style" });

//Users_Artist
User.belongsToMany(Artist, {
	through: Users_Artist,
	foreignKey: "id_user",
	unique: false,
});
Artist.belongsToMany(User, {
	through: Users_Artist,
	foreignKey: "id_artist",
	unique: false,
});

//Users_Style
User.belongsToMany(Style, {
	through: Users_Style,
	foreignKey: "id_user",
	unique: false,
});
Style.belongsToMany(User, {
	through: Users_Style,
	foreignKey: "id_style",
	unique: false,
});

//Relation between users and pics
User.hasMany(Pic, { foreignKey: "id_pic" });
Pic.belongsTo(User, { foreignKey: "id_pic" });

// // Relation between users and socials
// User.belongsTo(Social, { foreignKey: "id_user_one" });
// User.belongsTo(Social, { foreignKey: "id_user_two" });

// // Relation between users and mascotte
// User.belongsTo(Mascotte, { foreignKey: "id_user" });
// Mascotte.belongsTo(User, { foreignKey: "id_user" });

export default sequelize;
