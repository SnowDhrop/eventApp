import express from "express";
const router = express.Router();

import {
	emailValidator,
	userNameValidator,
	passwordValidator,
	ageValidator,
} from "./../validators/user.js";

import { signupCtrl, loginCtrl, getOneCtrl } from "./../controllers/user.js";
import auth from "./../middlewares/auth.js";

router.post(
	"/signup",
	emailValidator,
	userNameValidator,
	passwordValidator,
	ageValidator,
	signupCtrl
);

router.get("/login", emailValidator, passwordValidator, loginCtrl);

router.get("/:id", auth, getOneCtrl);

export default router;
