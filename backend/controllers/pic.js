import sequelize from "../src/database/connection.js";
import fs from "fs";
import path from "path";

import multer from "./../config/multer-config.js";

const Pic = sequelize.models.pic;
const User = sequelize.models.user;

// export const createCtrl = (req, res, next) => {
// 	Pic.create({
// 		...req.body,
// 	})
// 		.then(() => res.status(200).json({ message: "Pic created" }))
// 		.catch((err) =>
// 			res.status(500).json({ message: "Server error", error: err })
// 		);
// };

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

export const getProf = (req, res, next) => {
	const userId = req.auth.userId;

	const getProfilPic = (userFolder, boolean) => {
		fs.readdir(userFolder, (err, files) => {
			if (err) throw err;

			fs.access(userFolder, fs.constants.F_OK, (err) => {
				if (err) {
					res.status(404).json({ error: "Profile image not found" });
				} else {
					let imageSended = null;

					if (boolean === true) {
						files.map((image) => {
							if (image.includes("profil")) {
								imageSended = image;
							}
						});
					} else {
						imageSended = files[0];
					}

					const image = path.join(userFolder, imageSended);

					res.sendFile(path.resolve(image));
				}
			});
		});
	};

	if (fs.existsSync(`./public/images/user${userId}/`)) {
		getProfilPic(`./public/images/user${userId}/`, true);
	} else {
		getProfilPic(`./public/images/default/`, false);
	}
};
