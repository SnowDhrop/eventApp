import fs from "fs";
import path from "path";

const getProf = async (req, res, next) => {
	let users = req.users.users;
	let usersInfos = null;

	//Core function
	const getProfilPic = (userFolder, boolean, user) => {
		return new Promise((resolve, reject) => {
			fs.readdir(userFolder, (err, files) => {
				if (err) throw err;

				fs.access(userFolder, fs.constants.F_OK, async (err) => {
					if (err) {
						res.status(404).json({
							error: "Profile image not found",
						});
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

						const imagePath = path.join(userFolder, imageSended);
						const imageBuffer = await fs.promises.readFile(
							imagePath
						);
						const imageBase64 = imageBuffer.toString("base64");

						resolve({
							pseudo: user.pseudo,
							birthday: user.birthday,
							createdAt: user.createdAt,
							profilePic: imageBase64,
						});
					}
				});
			});
		});
	};

	// If request is from getALL
	if (users.length > 0) {
		try {
			// Check if user have upload a pic
			const usersInfosPromises = users.map(async (user) => {
				if (fs.existsSync(`./public/images/user${user.id_user}/`)) {
					return await getProfilPic(
						`./public/images/user${user.id_user}/`,
						true,
						user
					);
				} else {
					return await getProfilPic(
						`./public/images/default/`,
						false,
						user
					);
				}
			});

			usersInfos = await Promise.all(usersInfosPromises);
		} catch (error) {
			res.status(400).json({ error });
		}

		// If request is from getOne
	} else {
		try {
			if (fs.existsSync(`./public/images/user${users.id_user}/`)) {
				usersInfos = await getProfilPic(
					`./public/images/user${users.id_user}/`,
					true,
					users
				);
			} else {
				usersInfos = await getProfilPic(
					`./public/images/default/`,
					false,
					users
				);
			}
		} catch (error) {
			res.status(400).json({ error });
		}
	}
	res.status(200).json({ users: usersInfos });
};

export default getProf;
