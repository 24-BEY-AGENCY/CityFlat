import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import '../config/api_constants.dart';
import '../models/user_model.dart';
import '../providers/token_provider.dart';
import 'dio_service.dart';

class UserService {
  Future<User> updateUser(User user) async {
    try {
      final response = await DioService().dio.put(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/${user.id}",
            data: jsonEncode({
              'name': user.name,
              'email': user.email,
              'number': user.number,
              'address': user.address,
              'isVerified': user.isVerified,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        User newUser = User.fromJson(responseData);
        return newUser;
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

  Future<dynamic> deleteUser(String userId) async {
    try {
      final response = await DioService().dio.delete(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$userId");

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

  Future<User> getOneUser(String userInfo) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$userInfo",
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        User user = User.fromJson(responseData);
        return user;
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

  Future<List<User>> getAllUsers() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        final userArray = responseData;

        List<User> userList = [];
        for (var oneUserJson in userArray) {
          User oneUser = User.fromJson(oneUserJson);

          userList.add(oneUser);
        }
        return userList;
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
