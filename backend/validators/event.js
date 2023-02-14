import { check } from "express-validator";

export const titleValidator = [
	check("title", "How do you want to name your event ?")
		.isLength({ min: 2, max: 45 })
		.withMessage("Your title must have between 2 and 16 characters")
		.isString()
		.withMessage("Your title can't have special characters")
		.trim()
		.escape(),
];

export const descriptionValidator = [
	check("description", "Don't you want to give a description of your event ?")
		.isLength({ min: 2, max: 500 })
		.withMessage("Your description must have between 2 and 500 characters")
		.trim()
		.escape(),
];

export const categoryValidator = [
	check("category", "Select a category")
		.isLength({ min: 2, max: 45 })
		.withMessage("The category name must have between 2 and 45 characters")
		.isString()
		.withMessage("The category name can't have special characters")
		.trim()
		.escape(),
];

export const participantsValidator = [
	check(
		"participants",
		"If you already known how many person will come, tell us "
	)
		.isNumeric()
		.withMessage("The number of participants must be a number")
		.trim()
		.escape(),
];

export const addressValidator = [
	check("address", "Where will be your event ?")
		.isLength({ min: 2, max: 70 })
		.withMessage("Please give us a correct address")
		.trim()
		.escape(),
];

export const locationValidator = [
	check(
		"location",
		"If you know the exact position of the event (latitude/longitude), please tell us"
	)
		.isLength({ min: 2, max: 30 })
		.withMessage("Please give us a correct location")
		.trim()
		.escape(),
];

export const startDateValidator = [
	check("startDate", "When will begin your event ?")
		.isISO8601()
		.toDate()
		.withMessage("Choose a date")
		.trim()
		.escape(),
];

export const endDateValidator = [
	check("endDate", "When will finish your event ?")
		.isISO8601()
		.toDate()
		.withMessage("Choose a date")
		.trim()
		.escape(),
];

export const privateValidator = [
	check("private", "Do you want to set your event as private ?")
		.isNumeric()
		.withMessage("Choose an answer")
		.trim()
		.escape(),
];

export const activeValidator = [
	check("active", "Do you want to already set your event as active ?")
		.isNumeric()
		.withMessage("Choose an answer")
		.trim()
		.escape(),
];
