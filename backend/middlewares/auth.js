import jwt from "jsonwebtoken";

const auth = (req, res, next) => {
	try {
		const token = req.headers.authorization.split(" ")[1];
		const decodedToken = jwt.verify(token, "A_CHANGER");
		const userId = decodedToken.userId;

		req.auth = { userId };

		//Compare l'id envoyé dans le body et celui enregistré dans le token et l'enregistre dans req.auth
		if (req.body.userId && req.body.userId !== userId) {
			throw "Invalid user ID";
		} else {
			next();
		}
	} catch (error) {
		res.status(401).json({ error: "Requête non authentifiée" });
	}
};

export default auth;
