import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/api_constants.dart';
import '../models/book_date_model.dart';
import '../models/order_model.dart';
import 'dio_service.dart';

class OrderService {
  Future<Order> createOrder(Order order) async {
    try {
      final response = await DioService().dio.post(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.reservationEndpoint}/createOrder",
            data: jsonEncode({
              'appartment': order.appartment,
              'totalPrice': order.totalPrice,
              'startDate': order.startDate!.toIso8601String(),
              'endDate': order.endDate!.toIso8601String(),
              'servicesFee': order.servicesFee,
              'services': order.services,
            }),
          );
      Map<String, dynamic> responseData = response.data;

      if (response.statusCode == 201) {
        Order newOrder = Order.fromJsonCreate(responseData);
        return newOrder;
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

  Future<List<Order>> getAllOrdersByUser() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.orderEndpoint}/GetAcceptedAndPaidUO",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        List<Order> orderList = [];
        for (var oneOrderJson in responseData) {
          Order oneOrder = Order.fromJsonList(oneOrderJson);

          orderList.add(oneOrder);
        }
        return orderList;
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
      throw error;
    }
  }

  Future<List<Order>> getAcceptedOrdersByUser() async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.orderEndpoint}/GetAcceptedUO",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        List<Order> orderList = [];
        for (var oneOrderJson in responseData) {
          Order oneOrder = Order.fromJsonList(oneOrderJson);

          orderList.add(oneOrder);
        }
        return orderList;
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
      throw error;
    }
  }

  Future<List<BookDate>> getAcceptedBookDates(String apartmentId) async {
    try {
      final response = await DioService().dio.get(
          "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.orderEndpoint}/bookeddates/$apartmentId");

      final responseData = response.data;

      if (response.statusCode == 200) {
        List<BookDate> bookDateList = [];
        for (var oneBookDateJson in responseData) {
          BookDate oneBookDate = BookDate.fromJson(oneBookDateJson);

          bookDateList.add(oneBookDate);
        }
        return bookDateList;
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

  Future<Order> getOneOrderByUser(String orderId) async {
    try {
      final response = await DioService().dio.get(
            "${ApiConstants.baseUrl}${ApiConstants.userEndpoint}${ApiConstants.reservationEndpoint}/getOneOrder/$orderId",
          );

      final responseData = response.data;

      if (response.statusCode == 200) {
        Order order = Order.fromJson(responseData);

        return order;
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
