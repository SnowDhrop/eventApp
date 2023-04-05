import express from "express";

const router = express.Router();

import * as pic from "./../controllers/pic.js";

import auth from "./../middlewares/auth.js";

router.post("/upload", auth, pic.upload);

export default router;
