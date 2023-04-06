import multer from "multer";
import fs from "fs";

const MIME_TYPES = {
	"image/jpg": "jpg",
	"image/jpeg": "jpg",
	"image/png": "png",
};

const storage = multer.diskStorage({
	destination: (req, file, callback) => {
		const userFolder = `./public/images/user${req.auth.userId}`;

		//Create folder if there is not
		if (!fs.existsSync(userFolder)) {
			fs.mkdirSync(userFolder, { recursive: true });
		}
		callback(null, userFolder);
	},

	filename: (req, file, callback) => {
		const userFolder = `./public/images/user${req.auth.userId}`;

		fs.readdir(userFolder, (err, files) => {
			if (err) throw err;

			// Verify if there is file in dir
			const checkIfFiles = (files, userFolder) => {
				if (files.length !== 0) {
					for (const file of files) {
						if (file.startsWith("profil.")) {
							fs.unlink(`${userFolder}/${file}`, (err) => {
								if (err) throw err;
							});
						}
					}
				}
			};

			// Check if the extension is valid
			if (!Object.keys(MIME_TYPES).includes(file.mimetype)) {
				callback(new Error("Invalid file type"));
			} else {
				const extension = MIME_TYPES[file.mimetype];

				checkIfFiles(files, userFolder);

				//Download file
				callback(null, `profil.${extension}`);
			}
		});
	},
});

export default multer({ storage }).single("image");
