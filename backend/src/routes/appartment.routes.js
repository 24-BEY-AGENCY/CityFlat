import express from "express";
import multer from "../middlewares/multer_config.js";

import {
  httpGetAllApparts,
  httpGetAllAppartsWishlisted,
  httpAddAppartment,
  httpGetOneAppartment,
  httpGetOneAppartmentWishlist,
  httpUpdateOneAppartment,
  httpDeleteOneAppart,
} from "../controllers/apartment.controller.js";
// https://citynew.onrender.com/
import {
  getAllReviews,
  createReview,
  deleteReview,
  updateReview,
} from "../controllers/review.controller.js";
import { ensureUser } from "../middlewares/authorization-handler.js";

/** Defining the router */
const appartmentRouter = express.Router();

appartmentRouter.route("/addapartment").post(httpAddAppartment);

appartmentRouter.route("/edit/:id").put(httpUpdateOneAppartment);

appartmentRouter
  .route("/reviews/:param")
  .post(ensureUser, createReview)
  .get(getAllReviews)
  .delete(ensureUser, deleteReview);

appartmentRouter.route("/updateReviews/:param").put(ensureUser, updateReview);
appartmentRouter.route("/:id/delete").delete(httpDeleteOneAppart);
appartmentRouter.route("/getAllAppart").get(httpGetAllApparts);
appartmentRouter
  .route("/getAllAppartWishlisted")
  .get(ensureUser, httpGetAllAppartsWishlisted);
appartmentRouter
  .route("/:id/httpGetOneAppartmentWishlist")
  .get(ensureUser, httpGetOneAppartmentWishlist);

export { appartmentRouter };
