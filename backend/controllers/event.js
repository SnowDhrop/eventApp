import { validationResult, check } from "express-validator";
import bcrypt from "bcrypt";
import { use } from "bcrypt/promises.js";
import Event from "../src/models/Event.js";
import sequelize from "../src/database/connection.js";
import { Op } from "sequelize";

export const createCtrl = (req, res, next) => {};

export const getOneCtrl = (req, res, next) => {};

export const getAllCtrl = (req, res, next) => {};
