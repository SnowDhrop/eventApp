import sequelize from "../database/connection.js";

import User from "./User.js";

sequelize.define("user", User);

export default sequelize;
