import 'package:cityflat/models/apartment_model.dart';
import 'package:flutter/foundation.dart';

import 'user_model.dart';

class Order {
  String? id;
  dynamic user;
  dynamic appartment;
  num? totalPrice;
  DateTime? startDate;
  DateTime? endDate;
  num? servicesFee;
  bool? isPaied;
  List<dynamic>? services;
  String? state;
  DateTime? updatedAt;
  Order({
    this.id,
    this.user,
    this.appartment,
    this.totalPrice,
    this.startDate,
    this.endDate,
    this.servicesFee,
    this.isPaied,
    this.services,
    this.state,
    this.updatedAt,
  });

  Order copyWith({
    String? id,
    dynamic user,
    dynamic appartment,
    String? description,
    num? totalPrice,
    DateTime? startDate,
    DateTime? endDate,
    num? servicesFee,
    num? nightsFee,
    bool? isPaied,
    List<dynamic>? services,
    String? state,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      user: user ?? this.user,
      appartment: appartment ?? this.appartment,
      totalPrice: totalPrice ?? this.totalPrice,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      servicesFee: servicesFee ?? this.servicesFee,
      isPaied: isPaied ?? this.isPaied,
      services: services ?? this.services,
      state: state ?? this.state,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'appartment': appartment,
      'totalPrice': totalPrice,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'servicesFee': servicesFee,
      'isPaied': isPaied,
      'services': services,
      'state': state,
      'updatedAt': updatedAt,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] != null ? map['id'] as String : null,
      user: map['User'] as dynamic,
      appartment: map['appartment'] as dynamic,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as num : null,
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int)
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int)
          : null,
      servicesFee:
          map['servicesFee'] != null ? map['servicesFee'] as num : null,
      isPaied: map['isPaied'] != null ? map['isPaied'] as bool : null,
      services: map['services'] != null
          ? List<dynamic>.from((map['services'] as List<dynamic>))
          : null,
      state: map['state'] != null ? map['state'] as String : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'appartment': appartment,
      'totalPrice': totalPrice,
      'startDate': startDate,
      'endDate': endDate,
      'servicesFee': servicesFee,
      'isPaied': isPaied,
      'services': services,
      'state': state,
      'updatedAt': updatedAt,
    };
  }

  factory Order.fromJsonCreate(Map<String, dynamic> responseData) {
    return Order(
      id: responseData['id'],
      user: responseData['User'],
      appartment: responseData['appartment'],
      totalPrice: responseData['totalPrice'],
      startDate: DateTime.parse(responseData['startDate']),
      endDate: DateTime.parse(responseData['endDate']),
      servicesFee: responseData['servicesFee'],
      isPaied: responseData['isPaied'],
      services: responseData['services'],
      state: responseData['state'],
      updatedAt: DateTime.parse(responseData['updatedAt']),
    );
  }
  factory Order.fromJson(Map<String, dynamic> responseData) {
    return Order(
      id: responseData['id'],
      user: User.fromJson(responseData['User']),
      appartment: Apartment.fromJson(responseData['appartment']),
      totalPrice: responseData['totalPrice'],
      startDate: DateTime.parse(responseData['startDate']),
      endDate: DateTime.parse(responseData['endDate']),
      servicesFee: responseData['servicesFee'],
      isPaied: responseData['isPaied'],
      services: responseData['services'],
      state: responseData['state'],
      updatedAt: responseData['updatedAt'] != null
          ? DateTime.parse(responseData['updatedAt'])
          : null,
    );
  }
  factory Order.fromJsonList(Map<String, dynamic> responseData) {
    return Order(
      id: responseData['id'],
      user: User.fromJson(responseData['User']),
      appartment: responseData['appartment'],
      totalPrice: responseData['totalPrice'],
      startDate: DateTime.parse(responseData['startDate']),
      endDate: DateTime.parse(responseData['endDate']),
      servicesFee: responseData['servicesFee'],
      isPaied: responseData['isPaied'],
      services: responseData['services'],
      state: responseData['state'],
    );
  }
  @override
  String toString() {
    return 'Order(id: $id, user: $user, appartment: $appartment,  totalPrice: $totalPrice, startDate: $startDate, endDate: $endDate, servicesFee: $servicesFee,  isPaied: $isPaied, services: $services, state: $state, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.appartment == appartment &&
        other.totalPrice == totalPrice &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.servicesFee == servicesFee &&
        other.isPaied == isPaied &&
        listEquals(other.services, services) &&
        other.state == state &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        appartment.hashCode ^
        totalPrice.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        servicesFee.hashCode ^
        isPaied.hashCode ^
        services.hashCode ^
        state.hashCode ^
        updatedAt.hashCode;
  }
}
