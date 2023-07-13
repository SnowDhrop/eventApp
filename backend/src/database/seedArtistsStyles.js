import sequelize from "./connection.js";
import Category from "../models/Category.js";
import Artist from "../models/Artists.js";
import Style from "../models/Style.js";
import fs from "fs";

let datasRaw = fs.readFileSync("./src/initial/allStylesArtists.json", "utf-8");

let datas = JSON.parse(datasRaw);

// console.log(json.pop.artists);

sequelize
	.sync({ force: false })
	// Truncate tables
	.then(() => {
		return Promise.all([
			Style.destroy({ where: {} }),
			Artist.destroy({ where: {} }),
		]);
	})

	.then(async () => {
		const stylePromises = Object.keys(datas).map(async (style) => {
			let styleData = {
				name: style,
			};

			let [styleInstance, created] = await Style.upsert(styleData);

			if (!created) {
				console.error("Unable to upsert style");
			}

			console.log(style);

			const array = datas[style].artists;

			const artistPromises = array.map(async (artist) => {
				let artistData = {
					id_style: styleInstance.dataValues.id_style,
					name: artist,
				};

				let [artistInstance, created] = await Artist.upsert(artistData, {
					timeout: 5000,
				});

				if (!created) {
					console.error("Unable to upsert artist");
				}
				console.log(artistInstance);
			});

			await Promise.all(artistPromises);
		});

		await Promise.all(stylePromises);

		console.log("Database is filled");
	})
	.catch((error) => {
		console.error("Unable to create tables: ", error);
	});
