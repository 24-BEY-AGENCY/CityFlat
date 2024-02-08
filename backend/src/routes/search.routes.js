import express from "express";

import {
  searchByName,
  filterByPriceRange,
} from "../controllers/search.controller.js";
import { ensureUser } from "../middlewares/authorization-handler.js";

/** Defining the router */
const searchRouter = express.Router();

searchRouter.route("/:param").get(ensureUser, searchByName);

searchRouter.route("/byPrice").post(ensureUser, filterByPriceRange);

export { searchRouter };
