import express from "express";
import {
	createCtrl,
	getOneCtrl,
	getAllCtrl,
	subscribeCtrl,
} from "../controllers/event.js";
const router = express.Router();

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import {
	titleValidator,
	descriptionValidator,
	categoryValidator,
	participantsValidator,
	addressValidator,
	cityValidator,
	locationValidator,
	startDateValidator,
	endDateValidator,
	privateValidator,
	activeValidator,
	participantsMaxValidator,
} from "./../validators/event.js";

router.get("/:id", getOneCtrl);
router.get("/", getAllCtrl);

router.post(
	"/",
	auth,
	titleValidator,
	descriptionValidator,
	categoryValidator,
	participantsValidator,
	participantsMaxValidator,
	addressValidator,
	cityValidator,
	locationValidator,
	startDateValidator,
	endDateValidator,
	privateValidator,
	activeValidator,
	createCtrl
);

router.post("/:id", auth, subscribeCtrl);

export default router;
