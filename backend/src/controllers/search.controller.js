import Appartment from "../models/appartment.model.js";
import {
  appartsListFormat,
  appartFormat,
} from "../controllers/apartment.controller.js";

//search by name
export async function searchByName(req, res) {
  const name = req.params.param;

  try {
    if (typeof name !== "string") {
      throw new Error("Name parameter must be a string");
    }

    const appartments = await Appartment.find({
      name: { $regex: name, $options: "i" },
    });

    res.status(200).json(appartsListFormat(appartments));
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
}
//search by price range
export async function filterByPriceRange(req, res) {
  const { minPrice, maxPrice } = req.body;
  try {
    const appartments = await Appartment.find({
      defaultPrice: {
        $gte: minPrice,
        $lte: maxPrice,
      },
    });
    console.log(appartments);

    res.status(200).json(appartsListFormat(appartments));
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
}
