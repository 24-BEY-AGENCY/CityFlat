import 'dart:io';

import 'package:cityflat/models/service_model.dart';
import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import 'dio_service.dart';

class ServicesService {
  Future<List<Service>> getAllServices() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/service/getAllServices",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        List<Service> serviceList = [];
        for (var oneServicenJson in responseData) {
          Service oneService = Service.fromJson(oneServicenJson);

          serviceList.add(oneService);
        }
        return serviceList;
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
      rethrow;
    }
  }
}
