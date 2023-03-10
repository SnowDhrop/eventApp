import User from "./../src/models/User.js";
import sequelize from "../src/database/connection.js";

const userVerif = (req, res, next) => {
	try {
		const User = sequelize.models.user;

		//      Check if user is admin
		User.findOne({
			where: { id_user: req.auth.userId },
			attributes: ["is_admin"],
		})
			.then((admin) => {
				if (admin.dataValues.is_admin != true) {
					//  Find user by id gave in params
					User.findOne({
						where: { id_user: req.params.id },
						attributes: ["id_user"],
					})
						.then((user) => {
							// Compare id of user with the id previously saved in req.auth
							if (user.id_user !== req.auth.userId) {
								return res
									.status(401)
									.json({ message: "Unauthorized request" });
							}
							next();
						})
						.catch((err) =>
							res.status(404).json({ error: "Object not found" })
						);
				} else {
					next();
				}
			})
			.catch((err) => res.status(400).json({ err }));
	} catch (error) {
		res.status(401).json({ error });
	}
};

export default userVerif;
