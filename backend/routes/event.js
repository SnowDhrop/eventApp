import express from "express";
import { getOneCtrl } from "../controllers/user.js";
const router = express.Router();

import auth from "./../middlewares/auth.js";
import userVerif from "./../middlewares/userVerif.js";

router.get("/:id", getOneCtrl);

export default router;
