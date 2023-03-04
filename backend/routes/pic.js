import express from "express";

const router = express.Router();

import { createCtrl } from "./../controllers/pic.js";

import auth from "./../middlewares/auth.js";

router.post("/", auth, createCtrl);

export default router;
