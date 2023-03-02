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
	check("id_category", "Select a category")
		.isNumeric()
		.withMessage("Please select a category")
		.trim()
		.escape(),
];

export const styleValidator = [
	check("id_category", "Select a category")
		.isNumeric()
		.withMessage("Please select a style")
		.trim()
		.escape(),
];

export const participantsValidator = [
	check(
		"participants",
		"If you already known how many people will come, tell us "
	)
		.optional()
		.isNumeric()
		.withMessage("The number of participants must be a number")
		.trim()
		.escape(),
];

export const participantsMaxValidator = [
	check("participants_max", "How many people can come ?")
		.optional()
		.isNumeric()
		.withMessage("The number of participants max must be a number")
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

export const cityValidator = [
	check("city", "Where will be your event ?")
		.optional()
		.isLength({ min: 2, max: 40 })
		.withMessage("Please give us a correct city")
		.trim()
		.escape(),
];

export const locationValidator = [
	check(
		"location",
		"If you know the exact position of the event (latitude/longitude), please tell us"
	)
		.optional()
		.isLength({ min: 2, max: 30 })
		.withMessage("Please give us a correct location")
		.trim()
		.escape(),
];

export const startDateValidator = [
	check("start_event", "When will begin your event ?")
		.isISO8601()
		.toDate()
		.withMessage("Choose a date")
		.trim()
		.escape(),
];

export const endDateValidator = [
	check("end_event", "When will finish your event ?")
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
		.optional()
		.isNumeric()
		.withMessage("Choose an answer")
		.trim()
		.escape(),
];
