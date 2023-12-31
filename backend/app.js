import express from "express";
import path from "path";

// import("./src/database/connection.js");

import sequelize from "./src/models/index.js";

import userRoutes from "./routes/user.js";
import eventRoutes from "./routes/event.js";
import picRoutes from "./routes/pic.js";
import styleRoutes from "./routes/style.js";
import categoryRoutes from "./routes/category.js";

const app = express();

app.use(express.json());

app.use((req, res, next) => {
	res.setHeader("Access-Control-Allow-Origin", "*");
	res.setHeader(
		"Access-Control-Allow-Headers",
		"Origin, X-Requested-With, Content, Accept, Content-Type, Authorization"
	);
	res.setHeader(
		"Access-Control-Allow-Methods",
		"GET, POST, PUT, DELETE, PATCH, OPTIONS"
	);
	next();
});

app.use("/user", userRoutes);

app.use("/event", eventRoutes);

app.use("/style", styleRoutes);

app.use("/category", categoryRoutes);

// app.use("/pics", express.static(path.join(__dirname, "images")));
app.use("/pic", picRoutes);

export default app;
