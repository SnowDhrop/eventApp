import multer from "multer";
import { v4 as uuidv4 } from "uuid";

const MIME_TYPES = {
	"image/jpg": "jpg",
	"image/jpeg": "jpg",
	"image/png": "png",
};

const storage = multer.diskStorage({
	destination: (req, file, callback) => {
		callback(null, "./../public/images/profile/");
	},
	filename: (req, file, callback) => {
		const name = file.originalname.split(" ").join("_");

		const extension = MIME_TYPES[file.mimetype];

		const uniqueId = uuidv4();
		callback(
			null,
			`profil___${uniqueId}_${name}_${Date.now()}.${extension}`
		);
	},
});

export default multer({ storage }).single("image");
