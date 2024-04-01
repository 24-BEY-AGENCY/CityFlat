import 'dart:convert';
import 'dart:io';

import 'package:cityflat/models/review_model.dart';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import 'dio_service.dart';

class ReviewService {
  Future<Review> createReview(Review review, String apartId) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}${ApiConstants.reviewEndpoint}/$apartId",
            data: jsonEncode({
              'UserName': review.UserName,
              'Rating': review.Rating,
              'Description': review.Description,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 201) {
        Review newReview = Review.fromJson(responseData);
        return newReview;
      } else {
        throw HttpException(responseData['message']);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw error.response!.data!["message"];
      } else {
        print(error.requestOptions);
        print(error.message);
        rethrow;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<Review> updateReview(Review review, String apartId) async {
    try {
      final response = await DioService().dio.put(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/updateReviews/$apartId",
            data: jsonEncode({
              'Rating': review.Rating,
              'Description': review.Description,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        Review newReview = Review.fromJson(responseData["object"]);
        return newReview;
      } else {
        throw HttpException(responseData['message']);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw error.response!.data!["message"];
      } else {
        print(error.requestOptions);
        print(error.message);
        rethrow;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> deleteReview(String reviewId, String apartId) async {
    try {
      final response = await DioService().dio.delete(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}${ApiConstants.reviewEndpoint}/$reviewId",
            data: jsonEncode({
              'apartmentId': apartId,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        return responseData;
      } else {
        throw HttpException(responseData['message']);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw error.response!.data!["message"];
      } else {
        print(error.requestOptions);
        print(error.message);
        rethrow;
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<Review>> getAllReviewsForOneApartment(String apartId) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}${ApiConstants.reviewEndpoint}/$apartId",
          );

      final responseData = response.data ?? [];

      if (response.statusCode == 200) {
        List<Review> reviewList = [];
        for (var oneReviewJson in responseData) {
          Review oneReview = Review.fromJson(oneReviewJson);

          reviewList.add(oneReview);
        }
        return reviewList;
      } else {
        throw HttpException(responseData['message']);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw error.response!.data!["message"];
      } else {
        print(error.requestOptions);
        print(error.message);
        rethrow;
      }
    } catch (error) {
      throw error;
    }
  }
}
