import express from "express";

const router = express.Router();

import {
	emailValidator,
	userNameValidator,
	passwordValidator,
	ageValidator,
} from "./../validators/user.js";
import { signupCtrl } from "./../controllers/user.js";

router.post(
	"/",
	emailValidator,
	userNameValidator,
	passwordValidator,
	ageValidator,
	signupCtrl
);

export default router;
