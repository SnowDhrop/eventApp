import { check } from "express-validator";

export const signupValidator = [
	check("email", "Veuillez écrire un email")
		.isEmail()
		.trim()
		.escape()
		.normalizeEmail(),
];
