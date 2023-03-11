import express from "express";
const router = express.Router();

import {
	emailValidator,
	pseudoValidator,
	passwordValidator,
	birthdayValidator,
} from "./../validators/user.js";

import {
	signupCtrl,
	loginCtrl,
	getOneCtrl,
	getAllCtrl,
	updateCtrl,
	deleteCtrl,
} from "./../controllers/user.js";

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import confirmationEmail from "./../middlewares/confirmationEmail.js";

router.post(
	"/signup",
	emailValidator,
	pseudoValidator,
	passwordValidator,
	birthdayValidator,
	signupCtrl,
	confirmationEmail
);

router.get("/login", emailValidator, passwordValidator, loginCtrl);

router.get("/search", auth, getAllCtrl);
router.get("/search/:param", auth, getOneCtrl);

router.put(
	"/:id",
	auth,
	userVerif,
	emailValidator,
	pseudoValidator,
	passwordValidator,
	updateCtrl
);

router.delete("/:id", auth, userVerif, deleteCtrl);

export default router;
