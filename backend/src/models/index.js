import sequelize from "../database/connection.js";

import User from "./User.js";
import Event from "./Event.js";
import Category from "./Category.js";
import Challenge from "./Challenge.js";
import Mascotte from "./Mascotte.js";
import Pic from "./Pic.js";
import Social from "./Social.js";

sequelize.define("user", User);
sequelize.define("event", Event);
sequelize.define("category", Category);
sequelize.define("challenge", Challenge);
sequelize.define("mascotte", Mascotte);
sequelize.define("pic", Pic);
sequelize.define("social", Social);

export default sequelize;
