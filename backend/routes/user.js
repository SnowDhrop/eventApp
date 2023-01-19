const express = require("express");
const router = express.Router();

const validator = require("./../validators/user");

const userCtrl = require("./../controllers/user");

router.post("/", validator.signup, userCtrl.signup);

module.exports = router;
