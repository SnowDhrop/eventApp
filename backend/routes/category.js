import express from "express";

import sequelize from "./../src/database/connection.js";

import auth from "./../middlewares/auth.js";

import { createCtrl } from "./../controllers/category.js";

const router = express.Router();

router.post("/", auth, createCtrl);

export default router;
