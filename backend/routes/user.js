import express from "express";
const router = express.Router();

import * as userValidators from "./../validators/user.js";

import * as userControllers from "./../controllers/user.js";

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import * as confirmationEmail from "./../middlewares/confirmationEmail.js";
import * as changePassMiddleware from "./../middlewares/changePass.js";
// import multer from "./../config/multer-config.js";

router.post(
	"/signup",
	userValidators.emailValidator,
	userValidators.pseudoValidator,
	userValidators.passwordValidator,
	userValidators.birthdayValidator,
	userControllers.signupCtrl,
	confirmationEmail.sendConfirmationEmail
);

router.get(
	"/login",
	userValidators.emailValidator,
	userValidators.passwordValidator,
	userControllers.loginCtrl
);

router.get("/search", auth, userControllers.getAllCtrl);
router.get("/search/:param", auth, userControllers.getOneCtrl);

router.put(
	"/:id",
	auth,
	userVerif,
	userValidators.emailValidator,
	userValidators.pseudoValidator,
	userValidators.passwordValidator,
	userControllers.updateCtrl
);

// router.post("/pic", multer, userControllers.addPic);

router.delete("/:id", auth, userVerif, userControllers.deleteCtrl);

router.get("/confirm/:code", confirmationEmail.confirmCodeCtrl);

router.post(
	"/changePassword",
	userControllers.changePass,
	changePassMiddleware.sendPasswordCode
);

export default router;
