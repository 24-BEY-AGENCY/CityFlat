import 'dart:io';

import 'package:cityflat/models/apartment_model.dart';
import 'package:cityflat/services/dio_service.dart';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';

class WishlistService {
  Future<dynamic> addToWishlist(String apartmentId) async {
    try {
      final response = await DioService().dio.put(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.wishlistEndpoint}/$apartmentId",
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

  Future<dynamic> removeFromWishlist(String apartmentId) async {
    try {
      final response = await DioService().dio.put(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/rmwishlist/$apartmentId",
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

  Future<List<Apartment>> getAllWishlist() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.wishlistEndpoint}/list",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        List<Apartment> allWishList = [];
        for (var oneWishlistJson in responseData) {
          Apartment oneWishlist = Apartment.fromJsonWishList(oneWishlistJson);

          allWishList.add(oneWishlist);
        }
        return allWishList;
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
