import express from "express";

const router = express.Router();

import { createCtrl } from "./../controllers/pic.js";

import auth from "./../middlewares/auth.js";

router.post("/", createCtrl);

export default router;
