import express from "express";

const router = express.Router();

import { signupValidator } from "./../validators/user.js";
import { signupCtrl } from "./../controllers/user.js";

router.post("/", signupValidator, signupCtrl);

export default router;
