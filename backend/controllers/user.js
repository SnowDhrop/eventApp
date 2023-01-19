exports.signup = (req, res, next) => {
	// SANITIZE DATAS

	res.status(201).json({ pouet: req.body });
};
