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

// sequelize.define("user", User);
// sequelize.define("event", Event);
// sequelize.define("category", Category);
// sequelize.define("challenge", Challenge);
// sequelize.define("mascotte", Mascotte);
// sequelize.define("pic", Pic);
// sequelize.define("social", Social);
// sequelize.define("style", Style);

// DEFINE FOREIGN KEYS
//User_Event
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

// User who create an event
User.hasMany(Event, { foreignKey: "id_creator" });
Event.belongsTo(User, { foreignKey: "id_creator" });

// Relation between event and style
Style.hasMany(Event, { foreignKey: "id_style" });
Event.belongsTo(Style, { foreignKey: "id_style" });

//Relation between event and category
Category.hasMany(Event, { foreignKey: "id_category" });
Event.belongsTo(Category, { foreignKey: "id_category" });

export default sequelize;
