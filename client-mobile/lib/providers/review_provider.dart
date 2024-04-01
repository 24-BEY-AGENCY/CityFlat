import 'package:cityflat/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  void setReviews(List<Review> reviews) {
    _reviews = reviews;
  }

  void addReview(Review newReview) {
    _reviews.add(newReview);
    notifyListeners();
  }

  void updateReview(Review updatedReview) {
    int index = _reviews.indexWhere((review) => review.id == updatedReview.id);
    if (index != -1) {
      _reviews[index] = updatedReview;
      notifyListeners();
    }
  }

  void deleteReview(String deletedReviewId) {
    _reviews.removeWhere((review) => review.id == deletedReviewId);
    notifyListeners();
  }
}
