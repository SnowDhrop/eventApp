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
import Users_Event from "./Users_Event.js";
import Users_Challenge from "./Users_Challenge.js";

// sequelize.define("user", User);
// sequelize.define("event", Event);
// sequelize.define("category", Category);
// sequelize.define("challenge", Challenge);
// sequelize.define("mascotte", Mascotte);
// sequelize.define("pic", Pic);
// sequelize.define("social", Social);
// sequelize.define("style", Style);

// DEFINE FOREIGN KEYS
//Users_Event
User.belongsToMany(Event, {
	through: Users_Event,
	foreignKey: "id_user",
	unique: false,
});
Event.belongsToMany(User, {
	through: Users_Event,
	foreignKey: "id_event",
	unique: false,
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
