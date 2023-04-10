import express from "express";
// import {
// 	createCtrl,
// 	getOneCtrl,
// 	getAllCtrl,
// 	subscribeCtrl,
// 	updateCtrl,
// 	deleteCtrl,
// } from "../controllers/event.js";

import * as event from "../controllers/event.js";

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import eventVerif from "./../middlewares/eventVerif.js";

// import {
// 	titleValidator,
// 	descriptionValidator,
// 	categoryValidator,
// 	participantsValidator,
// 	addressValidator,
// 	cityValidator,
// 	locationValidator,
// 	startDateValidator,
// 	endDateValidator,
// 	privateValidator,
// 	activeValidator,
// 	participantsMaxValidator,
// 	styleValidator,
// } from "./../validators/event.js";

import * as eventVal from "./../validators/event.js";

const router = express.Router();

router.get("/search/:id", event.getOneCtrl);
router.get("/", event.getAllCtrl);

router.post(
	"/",
	auth,
	eventVal.titleValidator,
	eventVal.descriptionValidator,
	eventVal.categoryValidator,
	eventVal.styleValidator,
	eventVal.participantsValidator,
	eventVal.participantsMaxValidator,
	eventVal.addressValidator,
	eventVal.cityValidator,
	eventVal.locationValidator,
	eventVal.startDateValidator,
	eventVal.endDateValidator,
	eventVal.privateValidator,
	eventVal.activeValidator,
	event.createCtrl
);

router.put(
	"/:id",
	auth,
	eventVerif,
	eventVal.titleValidator,
	eventVal.descriptionValidator,
	eventVal.categoryValidator,
	eventVal.styleValidator,
	eventVal.participantsValidator,
	eventVal.participantsMaxValidator,
	eventVal.addressValidator,
	eventVal.cityValidator,
	eventVal.locationValidator,
	eventVal.startDateValidator,
	eventVal.endDateValidator,
	eventVal.privateValidator,
	eventVal.activeValidator,
	event.updateCtrl
);

router.delete("/:id", auth, eventVerif, event.deleteCtrl);

router.get("/:id", auth, event.subscribeCtrl);

export default router;
