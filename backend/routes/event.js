import express from "express";
import { getOneCtrl, createCtrl } from "../controllers/event.js";
const router = express.Router();

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";
import {
	titleValidator,
	descriptionValidator,
	categoryValidator,
	participantsValidator,
	addressValidator,
	locationValidator,
	startDateValidator,
	endDateValidator,
	privateValidator,
	activeValidator,
} from "./../validators/event.js";

router.get("/:id", getOneCtrl);
router.post("/", auth, createCtrl);

export default router;
