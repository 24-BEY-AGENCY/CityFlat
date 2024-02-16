import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import '../models/apartment_model.dart';
import 'dio_service.dart';

class ApartmentService {
  Future<Apartment> createApartment(Apartment apartment) async {
    try {
      List<MultipartFile> images = [];

      for (File imageFile in apartment.img!) {
        String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
        images.add(await MultipartFile.fromFile(
          imageFile.path,
          filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ));
      }

      FormData data = FormData.fromMap({
        'name': apartment.name,
        'description': apartment.description,
        'defaultPrice': apartment.defaultPrice,
        'FromDate': apartment.FromDate!.toIso8601String(),
        'ToDate': apartment.ToDate!.toIso8601String(),
        'location': apartment.location,
        'rooms': apartment.rooms,
        'img': images,
      });

      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.apartmentEndpoint}/addAppartment",
            data: FormData.fromMap({
              'name': apartment.name,
              'description': apartment.description,
              'defaultPrice': apartment.defaultPrice,
              'FromDate': apartment.FromDate!.toIso8601String(),
              'ToDate': apartment.ToDate!.toIso8601String(),
              'location': apartment.location,
              'rooms': apartment.rooms,
              'img': images,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 201) {
        Apartment newApartment = Apartment.fromJson(responseData);
        return newApartment;
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

  Future<Apartment> updateApartment(Apartment apartment, String apartId) async {
    try {
      var pricePerNight = [];
      for (var price in apartment.pricePerNight!) {
        var stringDate = price.date!.toIso8601String();
        pricePerNight.add({"date": stringDate, "price": price.price!});
      }

      final response = await DioService().dio.put(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.apartmentEndpoint}/$apartId",
            data: jsonEncode({
              'description': apartment.description,
              'pricePerNight': pricePerNight,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        Apartment newApartment = Apartment.fromJson(responseData);
        return newApartment;
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

  Future<dynamic> deleteApartment(String apartId) async {
    try {
      final response = await DioService().dio.delete(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.apartmentEndpoint}/$apartId",
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

  Future<Apartment> getOneApartment(String apartId) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.apartmentEndpoint}/$apartId/getOneAppartWishlisted",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        Apartment apartment = Apartment.fromJsonOne(responseData);

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
