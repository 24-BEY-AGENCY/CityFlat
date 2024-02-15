import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import '../models/user_model.dart';
import 'dio_service.dart';

class AuthService {
  Future<User> registerUser(User user) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/register",
            data: jsonEncode({
              'name': user.name,
              'email': user.email,
              'password': user.password,
              'number': user.number,
            }),
          );
      final Map<String, dynamic> responseData = response.data;
      if (response.statusCode == 201) {
        User user = User.fromJson(responseData);
        return user;
      } else {
        throw HttpException(responseData['message']);
      }
    } on DioException catch (error) {
      if (error.response != null) {
        throw error.response!.data!["error"];
      } else {
        print(error.requestOptions);
        print(error.message);
        rethrow;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> verifyEmail(
      {required String email, required String verifCode}) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/verify/$email",
            data: jsonEncode({
              'verificationCode': verifCode,
            }),
          );
      final Map<String, dynamic> responseData = json.decode(response.data);
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
      rethrow;
    }
  }

  Future<dynamic> resendVerificationEmail(String userInfo) async {
    try {
      final response = await DioService().dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/verify/$userInfo");
      final Map<String, dynamic> responseData = json.decode(response.data);
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
      rethrow;
    }
  }

  Future<User> loginUser(User user) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/login",
            data: jsonEncode({
              'email': user.email,
              'password': user.password,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        User loggedUser = User.fromJson(responseData);
        return loggedUser;
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

  Future<User> googleLoginUser(String email) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/auth/google",
            data: jsonEncode({
              'email': email,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        User loggedUser = User.fromJson(responseData);
        return loggedUser;
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

  Future<dynamic> resetPassword(Map<String, String> userData) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/reset/${userData['email']}",
            data: jsonEncode({
              'oldPassword': userData['oldPassword'],
              'newPassword': userData['newPassword'],
            }),
          );
      Map<dynamic, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        return responseData['message'];
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

  Future<dynamic> resetPasswordByEmail(String email) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/reset/$email",
          );
      Map<dynamic, dynamic> responseData = response.data;

      if (response.statusCode == 200) {
        return responseData['message'];
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
