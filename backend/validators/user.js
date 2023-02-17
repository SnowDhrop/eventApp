import { check } from "express-validator";

export const emailValidator = [
	check("email", "Please write a correct email")
		.isEmail()
		.trim()
		.escape()
		.normalizeEmail(),
];

export const pseudoValidator = [
	check("pseudo", "Choose a pseudo")
		.isLength({ min: 2, max: 8 })
		.withMessage("Your pseudo must have between 2 and 8 characters")
		.isString()
		.withMessage("Your pseudo can't have special characters")
		.matches(/^[a-zA-Z0-9]+$/)
		.withMessage(
			"Your pseudo must contain only numbers and letters without spaces"
		)
		.trim()
		.escape(),
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

const minAge = new Date();
minAge.setFullYear(minAge.getFullYear() - 16);

export const birthdayValidator = [
	check("birthday", "We need your bithday date")
		// Format norme ISO 8601 YYYY-MM-DD.
		.isISO8601()
		.withMessage("Please  send an ISO 8601 format date")
		.custom((value) => {
			const date = new Date(value);
			return date <= minAge;
		})
		.withMessage("Minimum age required is 16 years")
		.trim()
		.escape(),
];
