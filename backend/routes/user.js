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

router.post(
	"/signup",
	emailValidator,
	pseudoValidator,
	passwordValidator,
	birthdayValidator,
	signupCtrl
);

router.get("/login", emailValidator, passwordValidator, loginCtrl);

router.get("/search", auth, getAllCtrl);
// router.get("/search/:id", auth, getOneCtrl);
// router.get("/search/pseudo=:pseudo", auth, getOneCtrl);
// router.get("/search/email=:email", auth, getOneCtrl);
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
