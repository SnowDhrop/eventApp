import sequelize from "../src/database/connection.js";
import fs from "fs";
import path from "path";

import multer from "./../config/multer-config.js";

const Pic = sequelize.models.pic;
const User = sequelize.models.user;

export const uploadProf = (req, res, next) => {
	multer(req, res, (err) => {
		if (err) {
			return res.status(500).send({ err });
		}

		const updateDB = () => {
			User.update(
				{
					default_pic: false,
				},
				{
					where: { id_user: req.auth.userId },
				}
			)
				.then(() => {
					res.status(200).send({
						message: "File uploaded successfully",
						filename: req.file.filename,
					});
				})
				.catch((err) => res.status(400).json({ err }));
		};

		updateDB();
	});
};
