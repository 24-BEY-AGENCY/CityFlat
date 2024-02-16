import 'dart:convert';

class PricePerNight {
  String? id;
  DateTime? date;
  num? price;
  PricePerNight({
    this.id,
    this.date,
    this.price,
  });

  PricePerNight copyWith({
    String? id,
    DateTime? date,
    num? price,
  }) {
    return PricePerNight(
      id: id ?? this.id,
      date: date ?? this.date,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date?.millisecondsSinceEpoch,
      'price': price,
    };
  }

  factory PricePerNight.fromMap(Map<String, dynamic> map) {
    return PricePerNight(
      id: map['id'] != null ? map['id'] as String : null,
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      price: map['price'] != null ? map['price'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PricePerNight.fromJson(Map<String, dynamic> responseData) {
    return PricePerNight(
      id: responseData['_id'],
      date: DateTime.parse(responseData['date']),
      price: responseData['price'],
    );
  }

  @override
  String toString() => 'PricePerNight(id: $id, date: $date, price: $price)';

  @override
  bool operator ==(covariant PricePerNight other) {
    if (identical(this, other)) return true;

    return other.id == id && other.date == date && other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ date.hashCode ^ price.hashCode;
}
