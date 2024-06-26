import mongoose from "mongoose";
import Review from "../models/review.model.js";
import Appartment from "../models/appartment.model.js";

export async function createReview(req, res) {
  try {
    const review = new Review({
      User: req.user.id,
      UserName: req.body.UserName,
      Rating: req.body.Rating,
      Description: req.body.Description,
    });
    const savedReview = await review.save();
    const apartment = await Appartment.findById(req.params.param);
    // Update total rating and number of reviews for the apartment
    const newSumOfRatings =
      parseInt(apartment.sumOfRatings) + parseInt(req.body.Rating);
    const numberOfRatings = apartment.reviews.length + 1;
    await Appartment.findByIdAndUpdate(req.params.param, {
      $push: { reviews: savedReview._id },
      sumOfRatings: newSumOfRatings,
      numOfRatings: numberOfRatings,
      rating: (newSumOfRatings / numberOfRatings).toFixed(1),
    })
      .then((result) => {
        res.status(201).json(savedReview);
      })
      .catch((err) => res.status(500).json({ error: err.message }));
  } catch (error) {
    throw new Error(error.message);
  }
}
//some fixes
export async function updateApartmentRating(req, res) {
  console.log("trying to update the apart rating", req);
  try {
    const newRatingValue = (req.sumOfRatings / req.numOfRatings).toFixed(1);
    const updatedRating = await Appartment.findByIdAndUpdate(req.params.param, {
      sumOfRatings: req.sumOfRatings,
      numOfRatings: req.numOfRatings,
      rating: newRatingValue,
    });
    res
      .status(200)
      .json({ message: "Rating updated successfully!", object: updatedRating });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

export async function updateReview(req, res) {
  console.log("body", req.body);
  try {
    const reviewId = req.params.param;
    const userId = req.user.id; // Assuming the user ID is stored in req.user._id
    const updatedReview = await Review.findOneAndUpdate(
      { _id: reviewId, User: userId }, // Check if both review ID and user ID match
      { Rating: req.body.Rating, Description: req.body.Description },
      { new: true }
    );

    if (!updatedReview) {
      return res
        .status(404)
        .json({ message: "Review not found or unauthorized" });
    }

    res.status(200).json({
      message: "Review updated successfully!",
      object: updatedReview,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}

export async function deleteReview(req, res) {
  try {
    const review = await Review.findById(req.params.param);
    if (!review) {
      return res.status(404).json({ error: "Review not found" });
    }
    console.log(review.User + "   " + req.user.id);
    if (review.User != req.user.id) {
      return res.status(403).json({ error: "Forbidden" });
    }

    console.log("apartmentId", req.body);

    const apartment = await Appartment.findByIdAndUpdate(
      req.body.apartmentId,
      { $pull: { reviews: review._id } },
      { new: true }
    );

    if (!apartment) {
      return res.status(404).json({ message: "Apartment not found" });
    }

    if (apartment.numOfRatings === 0) {
      // No ratings left, set rating to 0
      await apartment.updateOne({ rating: 0 });
    } else {
      // Calculate new average rating
      const newSumOfRatings = apartment.sumOfRatings - review.Rating;
      const numberOfRatings = apartment.numOfRatings - 1;
      const averageRating = (newSumOfRatings / numberOfRatings).toFixed(1);
      await apartment.updateOne({
        rating: averageRating,
        sumOfRatings: newSumOfRatings,
        numOfRatings: numberOfRatings,
      });
    }

    await review.delete();

    res.status(200).json({ message: "Deleted successfully!" });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
}

export async function getAllReviews(req, res) {
  try {
    const apartment = await Appartment.findById(req.params.param)
      .populate({ path: "reviews", populate: { path: "User", select: "img" } })
      .lean();
    const reviews = apartment.reviews?.map((review) => {
      return {
        ...review,
        User: review.User._id,
        img: review.User.img,
      };
    });

    res.status(200).json(reviews);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: error.message });
  }
}
