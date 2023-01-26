import { validationResult } from "express-validator";

export const signupCtrl = (req, res, next) => {
	const errors = validationResult(req);

	if (!errors.isEmpty()) {
		return res.status(422).json({ errors: errors.array() });
	}

	res.status(201).json({ pouet: req.body });
};
