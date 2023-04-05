import sequelize from "../src/database/connection.js";

import multer from "./../config/multer-config.js";

const Pic = sequelize.models.pic;

// export const createCtrl = (req, res, next) => {
// 	Pic.create({
// 		...req.body,
// 	})
// 		.then(() => res.status(200).json({ message: "Pic created" }))
// 		.catch((err) =>
// 			res.status(500).json({ message: "Server error", error: err })
// 		);
// };

export const upload = (req, res, next) => {
	multer(req, res, (err) => {
		if (err) {
			return res.status(500).send({ error: err });
		}

		console.log("YALA");

		// Récupérez l'identifiant de l'utilisateur connecté
		const userId = req.auth.userId;

		// Créez un dossier pour l'utilisateur s'il n'existe pas déjà
		const userFolder = `./../public/images/user/${userId}`;

		if (!fs.existsSync(userFolder)) {
			fs.mkdirSync(userFolder, { recursive: true });
		}

		console.log("YOLO");

		// Déplacez le fichier dans le dossier de l'utilisateur
		fs.rename(
			`./../public/images/user/${req.file.filename}`,
			`${userFolder}/profil/${req.file.filename}`,
			(err) => {
				if (err) {
					return res
						.status(500)
						.send({ message: "Error moving file to user folder" });
				}

				// Mettez à jour la base de données avec le chemin du fichier, par exemple :
				// updateUserProfile(userId, `${userFolder}/${req.file.filename}`);

				res.status(200).send({
					message: "File uploaded successfully",
					filename: req.file.filename,
				});
			}
		);
	});
};
