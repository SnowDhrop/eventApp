import express from "express";
const router = express.Router();

import * as userValidators from "./../validators/user.js";

import * as userControllers from "./../controllers/user.js";

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import * as confirmationEmail from "./../middlewares/confirmationEmail.js";
import checkAccountValidity from "./../middlewares/checkAccountValidity.js";
import multer from "./../config/multer-config.js";

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

router.get("/search", auth, checkAccountValidity, userControllers.getAllCtrl);
router.get(
	"/search/:param",
	auth,
	checkAccountValidity,
	userControllers.getOneCtrl
);

router.put(
	"/:id",
	auth,
	userVerif,
	userValidators.emailValidator,
	userValidators.pseudoValidator,
	userValidators.passwordValidator,
	userControllers.updateCtrl
);

// ADD PROFILE PICTURE
// router.post("/pic", multer, userControllers.addPic);
//

router.delete(
	"/:id",
	auth,
	checkAccountValidity,
	userVerif,
	userControllers.deleteCtrl
);

router.get("/confirm/:code", confirmationEmail.confirmCodeCtrl);

// CHANGE PASSWORD
// Rajouter les validateurs pseudo et email
router.post(
	"/changePassword",
	checkAccountValidity,
	userControllers.changePassRequest,
	confirmationEmail.sendCodeChangePassword
);

router.get("/change/:code", confirmationEmail.changePassword);
// END CHANGE PASSWORD

export default router;
