import { check } from "express-validator";

export const emailValidator = [
	check("email", "Please write a correct email")
		.isEmail()
		.trim()
		.escape()
		.normalizeEmail(),
];

export const userNameValidator = [
	check("pseudo", "Choose a username")
		.isLength({ min: 2, max: 8 })
		.withMessage("Username must have between 2 and 8 characters")
		.isString()
		.withMessage("Username can't have special characters")
		.matches(/^[a-zA-Z0-9]+$/)
		.withMessage(
			"Your username must contain only numbers and letters without spaces"
		)
		.trim()
		.escape()
		.normalizeEmail(),
];

export const passwordValidator = [
	check("password", "Choose a password")
		.isLength({ min: 8, max: 16 })
		.withMessage("Your password must have between 8 and 16 characters")
		.matches("[0-9]")
		.withMessage("Your password must contain a number")
		.matches("[a-z]")
		.withMessage("Your password must contain a letter")
		.matches("[A-Z]")
		.withMessage("Your password must contain a capital letter")
		.matches("[-_=!;,?.:]")
		.withMessage(
			"Your password must contain one of these characters: -_=!;,?.:"
		)
		.trim()
		.escape(),
];

export const ageValidator = [
	check("age", "Say us your age")
		.isNumeric()
		.withMessage("Your age must be a number")
		.isInt({ min: 16, max: 120 })
		.withMessage("Minimum age required is 16")
		.trim()
		.escape(),
];
