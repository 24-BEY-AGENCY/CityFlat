import 'dart:convert';

import 'order_model.dart';

class Reservation {
  String? id;
  Order? order;
  String? code;
  bool? paied;
  String? transactionId;
  Reservation({
    this.id,
    this.order,
    this.code,
    this.paied,
    this.transactionId,
  });

  Reservation copyWith({
    String? id,
    Order? order,
    String? code,
    bool? paied,
    String? transactionId,
  }) {
    return Reservation(
      id: id ?? this.id,
      order: order ?? this.order,
      code: code ?? this.code,
      paied: paied ?? this.paied,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Order': Order,
      'code': code,
      'paied': paied,
      'transactionId': transactionId,
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'] != null ? map['id'] as String : null,
      order: map['Order'] != null ? map['Order'] as Order : null,
      code: map['code'] != null ? map['code'] as String : null,
      paied: map['paied'] != null ? map['paied'] as bool : null,
      transactionId:
          map['transactionId'] != null ? map['transactionId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Reservation.fromJson(Map<String, dynamic> responseData) {
    return Reservation(
      id: responseData['id'],
      order: Order.fromJson(responseData['Order']),
      code: responseData['code'],
      paied: responseData['paied'],
      transactionId: responseData['transactionId'],
    );
  }

  @override
  String toString() {
    return 'Reservation(id: $id, Order: $Order,code: $code, paied: $paied, transactionId: $transactionId)';
  }

  @override
  bool operator ==(covariant Reservation other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order == order &&
        other.code == code &&
        other.paied == paied &&
        other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        code.hashCode ^
        paied.hashCode ^
        transactionId.hashCode;
  }
}
