import express from "express";
import {
	createCtrl,
	getOneCtrl,
	getAllCtrl,
	subscribeCtrl,
	updateCtrl,
	deleteCtrl,
} from "../controllers/event.js";

const router = express.Router();

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import eventVerif from "./../middlewares/eventVerif.js";
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
	styleValidator,
} from "./../validators/event.js";

router.get("/:id", getOneCtrl);
router.get("/", getAllCtrl);

router.post(
	"/",
	auth,
	titleValidator,
	descriptionValidator,
	categoryValidator,
	styleValidator,
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

router.put(
	"/:id",
	auth,
	eventVerif,
	titleValidator,
	descriptionValidator,
	categoryValidator,
	styleValidator,
	participantsValidator,
	participantsMaxValidator,
	addressValidator,
	cityValidator,
	locationValidator,
	startDateValidator,
	endDateValidator,
	privateValidator,
	activeValidator,
	updateCtrl
);

router.delete("/:id", auth, eventVerif, deleteCtrl);

router.post("/:id", auth, subscribeCtrl);

export default router;
