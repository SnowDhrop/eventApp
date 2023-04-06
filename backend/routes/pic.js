import express from "express";

const router = express.Router();

import * as pic from "./../controllers/pic.js";

import auth from "./../middlewares/auth.js";
import checkAccountValidity from "../middlewares/checkAccountValidity.js";

router.post("/upload", auth, checkAccountValidity, pic.uploadProf);

router.get("/prof", auth, checkAccountValidity, pic.getProf);

export default router;
