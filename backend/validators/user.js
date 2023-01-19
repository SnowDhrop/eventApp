const { check, validationResult } = require("express-validator");

exports.signup = [
	check("email", "Veuillez écrire un email")
		.isEmail()
		.trim()
		.escape()
		.normalizeEmail(),
];
