import 'package:cityflat/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void setOrders(List<Order> orders) {
    _orders = orders;
  }

  void addOrder(Order newOrder) {
    _orders.add(newOrder);
    notifyListeners();
  }

  void deleteOrder(String deletedOrderId) {
    _orders.removeWhere((order) => order.id == deletedOrderId);
    notifyListeners();
  }
}
