import Appartment from "../models/appartment.model.js";
import {
  appartsListFormat,
  appartsIsWishlistedListFormat,
  appartFormat,
} from "../controllers/apartment.controller.js";
import userDb from "../models/user.model.js";

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

//search by price range and show the property isWishlisted
export async function filterByPriceRangeWishlist(req, res) {
  const { minPrice, maxPrice } = req.body;
  const userId = req.user.id;

  try {
    const appartments = await Appartment.find({
      defaultPrice: {
        $gte: minPrice,
        $lte: maxPrice,
      },
    });
    console.log(appartments);

    userDb.findOne({ _id: userId }, (err, user) => {
      if (err) {
        return res.status(500).json({ error: err.message });
      }

      if (!user) {
        return res.status(404).json({ error: "User not found" });
      }

      const updatedApparts = appartments.map((apartment) => {
        const isWishlist = user.wishlist.includes(apartment._id.toString());
        return { ...apartment.toObject(), isWishlist };
      });

      res.status(200).json(appartsIsWishlistedListFormat(updatedApparts));
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
}
