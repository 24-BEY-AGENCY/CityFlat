import 'dart:io';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import '../models/apartment_model.dart';
import 'dio_service.dart';

class ApartmentService {
  Future<List<Apartment>> getAllApartments() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/getAllAppart",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final apartmentArray = responseData;

        List<Apartment> apartmentList = [];
        for (var oneApartmentJson in apartmentArray) {
          Apartment oneApartment = Apartment.fromJson(oneApartmentJson);

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

  Future<List<Apartment>> getAllAppartWishlisted() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/getAllAppartWishlisted",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final apartmentArray = responseData;

        List<Apartment> apartmentList = [];
        for (var oneApartmentJson in apartmentArray) {
          Apartment oneApartment = Apartment.fromJson(oneApartmentJson);

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

  Future<List<Apartment>> getAllRentalsWishlisted() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/getRentalsWishlisted",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final apartmentArray = responseData;

        List<Apartment> apartmentList = [];
        for (var oneApartmentJson in apartmentArray) {
          Apartment oneApartment = Apartment.fromJson(oneApartmentJson);

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

  Future<Apartment> getOneApartment(String apartId) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/$apartId/httpGetOneAppartmentWishlist",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        Apartment apartment = Apartment.fromJson(responseData);

        return apartment;
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

  Future<Apartment> getOneRental(String apartId) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/$apartId/getOneRentalWishlist",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        Apartment apartment = Apartment.fromJson(responseData);

        return apartment;
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
