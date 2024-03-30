import 'dart:convert';

import 'package:flutter/material.dart';

class Service {
  String? id;
  String? name;
  String? description;
  num? pricePerNight;
  IconData? icon;
  bool? isSelected;
  Service({
    this.id,
    this.name,
    this.description,
    this.pricePerNight,
    this.icon,
    this.isSelected,
  });

  Service copyWith({
    String? id,
    String? name,
    String? description,
    num? pricePerNight,
    IconData? icon,
    bool? isSelected,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'pricePerNight': pricePerNight,
      'icon': icon,
      'isSelected': isSelected,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      pricePerNight:
          map['pricePerNight'] != null ? map['pricePerNight'] as num : null,
      isSelected: map['isSelected'] != null ? map['isSelected'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(Map<String, dynamic> responseData) {
    return Service(
      id: responseData['id'],
      name: responseData['name'],
      description: responseData['description'],
      pricePerNight: responseData['pricePerNight'],
    );
  }

  @override
  String toString() {
    return 'Service(id: $id, name: $name, description: $description, pricePerNight: $pricePerNight,)';
  }

  @override
  bool operator ==(covariant Service other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.pricePerNight == pricePerNight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        pricePerNight.hashCode;
  }
}
