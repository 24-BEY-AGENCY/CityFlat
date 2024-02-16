import 'dart:convert';
import 'dart:io';

import 'package:cityflat/models/apartment_model.dart';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import 'dio_service.dart';

class SerchService {
  Future<List<Apartment>> searchApartmentByName(String apartName) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.searchEndpoint}/$apartName",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final apartmentArray = responseData;

        List<Apartment> apartmentList = [];
        for (var oneApartmentJson in apartmentArray) {
          Apartment oneApartment = Apartment.fromJsonSearch(oneApartmentJson);

          apartmentList.add(oneApartment);
        }
        return apartmentList;
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

  Future<List<Apartment>> filterApartmentByPriceRange(
      num minPrice, num maxPrice) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.searchEndpoint}/byPriceWishlist",
            data: jsonEncode({
              'minPrice': minPrice,
              'maxPrice': maxPrice,
            }),
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final apartmentArray = responseData;

        List<Apartment> apartmentList = [];
        for (var oneApartmentJson in apartmentArray) {
          Apartment oneApartment = Apartment.fromJsonSearch(oneApartmentJson);

          apartmentList.add(oneApartment);
        }
        return apartmentList;
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
