import 'dart:convert';
import 'package:flutter/foundation.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  String? number;
  String? address;
  bool? isVerified;
  DateTime? birthdate;
  String? role;
  String? img;
  List<String?>? reservations;
  String? googleID;
  String? stripeCustomerID;
  List<String?>? wishlist;
  String? token;
  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.number,
    this.address,
    this.isVerified,
    this.birthdate,
    this.role,
    this.img,
    this.reservations,
    this.googleID,
    this.stripeCustomerID,
    this.wishlist,
    this.token,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? number,
    String? address,
    bool? isVerified,
    DateTime? birthdate,
    String? role,
    String? img,
    List<String?>? reservations,
    String? googleID,
    String? stripeCustomerID,
    List<String?>? wishlist,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      number: number ?? this.number,
      address: address ?? this.address,
      isVerified: isVerified ?? this.isVerified,
      birthdate: birthdate ?? this.birthdate,
      role: role ?? this.role,
      img: img ?? this.img,
      reservations: reservations ?? this.reservations,
      googleID: googleID ?? this.googleID,
      stripeCustomerID: stripeCustomerID ?? this.stripeCustomerID,
      wishlist: wishlist ?? this.wishlist,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'number': number,
      'address': address,
      'isVerified': isVerified,
      'birthdate': birthdate?.millisecondsSinceEpoch,
      'role': role,
      'img': img,
      // 'reservations': reservations!.map((x) => x?.toMap()).toList(),
      'googleID': googleID,
      'stripeCustomerID': stripeCustomerID,
      // 'wishlist': wishlist!.map((x) => x?.toMap()).toList(),
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      birthdate: map['birthdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthdate'] as int)
          : null,
      role: map['role'] != null ? map['role'] as String : null,
      img: map['img'] != null ? map['img'] as String : null,
      googleID: map['googleID'] != null ? map['googleID'] as String : null,
      stripeCustomerID: map['stripeCustomerID'] != null
          ? map['stripeCustomerID'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'],
      name: responseData['name'],
      email: responseData['email'],
      password: responseData['password'],
      number: responseData['number'],
      address: responseData['address'],
      isVerified: responseData['isVerified'],
      birthdate: responseData['birthdate'] != null
          ? DateTime.parse(responseData['birthdate'])
          : null,
      role: responseData['role'],
      img: responseData['img'],
      reservations: responseData['reservations'] != null
          ? List<String>.from(responseData['reservations'])
          : null,
      googleID: responseData['googleID'],
      stripeCustomerID: responseData['stripeCustomerID'],
      wishlist: responseData['wishlist'] != null
          ? List<String>.from(responseData['wishlist'])
          : null,
      token: responseData['token'],
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, number: $number, address: $address, isVerified: $isVerified, birthdate: $birthdate, role: $role, img: $img, reservations: $reservations, googleID: $googleID, stripeCustomerID: $stripeCustomerID, wishlist: $wishlist, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.number == number &&
        other.address == address &&
        other.isVerified == isVerified &&
        other.birthdate == birthdate &&
        other.role == role &&
        other.img == img &&
        listEquals(other.reservations, reservations) &&
        other.googleID == googleID &&
        other.stripeCustomerID == stripeCustomerID &&
        listEquals(other.wishlist, wishlist) &&
        other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        number.hashCode ^
        address.hashCode ^
        isVerified.hashCode ^
        birthdate.hashCode ^
        role.hashCode ^
        img.hashCode ^
        reservations.hashCode ^
        googleID.hashCode ^
        stripeCustomerID.hashCode ^
        wishlist.hashCode ^
        token.hashCode;
  }
}
