import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'book_date_model.dart';

class DefaultDateAndPrice {
  int price;
  DateTime startDate;
  DateTime endDate;

  DefaultDateAndPrice({
    required this.price,
    required this.startDate,
    required this.endDate,
  });

  factory DefaultDateAndPrice.fromJson(Map<String, dynamic> json) {
    return DefaultDateAndPrice(
      price: json['price'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

class SpecialDate {
  int? price;
  DateTime? startDate;
  DateTime? endDate;

  SpecialDate({
    this.price,
    this.startDate,
    this.endDate,
  });

  factory SpecialDate.fromJson(Map<String, dynamic> json) {
    return SpecialDate(
      price: json['price'],
      startDate:
          json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }
}

class Apartment {
  String? id;
  String? apartmentName;
  String? description;
  DefaultDateAndPrice? defaultDateAndPrice;
  List<SpecialDate>? specialDates;
  List<BookDate>? bookedDates;
  String? location;
  num? rooms;
  num? sumOfRatings;
  num? numOfRatings;
  num? rating;
  List<dynamic>? reviews;
  num? bedroom;
  num? bathroom;
  List<dynamic>? services;
  List<dynamic>? pictures;
  DateTime? FromDate;
  DateTime? ToDate;
  bool? isWishlist;
  Apartment({
    this.id,
    this.apartmentName,
    this.description,
    this.defaultDateAndPrice,
    this.specialDates,
    this.bookedDates,
    this.location,
    this.rooms,
    this.sumOfRatings,
    this.numOfRatings,
    this.rating,
    this.reviews,
    this.bedroom,
    this.bathroom,
    this.services,
    this.pictures,
    this.FromDate,
    this.ToDate,
    this.isWishlist,
  });

  Apartment copyWith({
    String? id,
    String? apartmentName,
    String? description,
    DefaultDateAndPrice? defaultDateAndPrice,
    List<SpecialDate>? specialDates,
    List<BookDate>? bookedDates,
    String? location,
    num? rooms,
    num? sumOfRatings,
    num? numOfRatings,
    num? rating,
    List<dynamic>? reviews,
    num? bedroom,
    num? bathroom,
    List<dynamic>? services,
    List<dynamic>? pictures,
    DateTime? FromDate,
    DateTime? ToDate,
    bool? isWishlist,
  }) {
    return Apartment(
      id: id ?? this.id,
      apartmentName: apartmentName ?? this.apartmentName,
      description: description ?? this.description,
      defaultDateAndPrice: defaultDateAndPrice ?? this.defaultDateAndPrice,
      specialDates: specialDates ?? this.specialDates,
      bookedDates: bookedDates ?? this.bookedDates,
      location: location ?? this.location,
      rooms: rooms ?? this.rooms,
      sumOfRatings: sumOfRatings ?? this.sumOfRatings,
      numOfRatings: numOfRatings ?? this.numOfRatings,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      bedroom: bedroom ?? this.bedroom,
      bathroom: bathroom ?? this.bathroom,
      services: services ?? this.services,
      pictures: pictures ?? this.pictures,
      FromDate: FromDate ?? this.FromDate,
      ToDate: ToDate ?? this.ToDate,
      isWishlist: isWishlist ?? this.isWishlist,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'apartmentName': apartmentName,
      'description': description,
      'defaultDateAndPrice': defaultDateAndPrice,
      'specialDates': specialDates,
      'location': location,
      'rooms': rooms,
      'sumOfRatings': sumOfRatings,
      'numOfRatings': numOfRatings,
      'rating': rating,
      'reviews': reviews,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'services': services,
      'pictures': pictures,
      'FromDate': FromDate?.millisecondsSinceEpoch,
      'ToDate': ToDate?.millisecondsSinceEpoch,
      'isWishlist': isWishlist,
    };
  }

  factory Apartment.fromMap(Map<String, dynamic> map) {
    return Apartment(
      id: map['id'] != null ? map['id'] as String : null,
      apartmentName:
          map['apartmentName'] != null ? map['apartmentName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      rooms: map['rooms'] != null ? map['rooms'] as num : null,
      sumOfRatings:
          map['sumOfRatings'] != null ? map['sumOfRatings'] as num : null,
      numOfRatings:
          map['numOfRatings'] != null ? map['numOfRatings'] as num : null,
      rating: map['rating'] != null ? map['rating'] as num : null,
      reviews: map['reviews'] != null
          ? List<dynamic>.from((map['reviews'] as List<dynamic>))
          : null,
      bedroom: map['bedroom'] != null ? map['bedroom'] as num : null,
      bathroom: map['bathroom'] != null ? map['bathroom'] as num : null,
      services: map['services'] != null
          ? List<String>.from((map['services'] as List<String>))
          : null,
      pictures: map['pictures'] != null
          ? List<dynamic>.from((map['pictures'] as List<dynamic>))
          : null,
      FromDate: map['FromDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['FromDate'] as int)
          : null,
      ToDate: map['ToDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['ToDate'] as int)
          : null,
      isWishlist: map['isWishlist'] != null ? map['isWishlist'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Apartment.fromJson(Map<String, dynamic> responseData) {
    List<BookDate>? convertedBookedDates;
    if (responseData['bookedDates'] != null) {
      convertedBookedDates = (responseData['bookedDates'] as List<dynamic>)
          .map((date) => BookDate.fromJson(date))
          .toList();
    }

    DefaultDateAndPrice? defaultDateAndPrice;
    if (responseData['defaultDateAndPrice'] != null) {
      defaultDateAndPrice =
          DefaultDateAndPrice.fromJson(responseData['defaultDateAndPrice']);
    }

    List<SpecialDate>? specialDates;
    if (responseData['specialDate'] != null) {
      specialDates = (responseData['specialDate'] as List<dynamic>)
          .map((specialDate) => SpecialDate.fromJson(specialDate))
          .toList();
    }

    List<String> services = [];

    if (responseData["parking"] ?? false) services.add("parking");
    if (responseData["rent"] ?? false) services.add("rent");
    if (responseData["food"] ?? false) services.add("food");
    if (responseData["laundry"] ?? false) services.add("laundry");

    List<String>? convertedImages = List<String>.from(responseData['pictures']);
    List<String>? moreImages = List<String>.from(responseData['more']);
    List<String>? allImages = [...convertedImages, ...moreImages];

    return Apartment(
      id: responseData['_id'],
      apartmentName: responseData['apartmentName'],
      description: responseData['description'],
      defaultDateAndPrice: defaultDateAndPrice,
      specialDates: specialDates,
      bookedDates: convertedBookedDates,
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: responseData['reviews'],
      bedroom: responseData['bedroom'],
      bathroom: responseData['bathroom'],
      services: services,
      pictures: allImages,
      isWishlist: responseData['isWishlist'],
    );
  }

  factory Apartment.fromJsonSearch(Map<String, dynamic> responseData) {
    DefaultDateAndPrice? defaultDateAndPrice;
    if (responseData['defaultDateAndPrice'] != null) {
      defaultDateAndPrice =
          DefaultDateAndPrice.fromJson(responseData['defaultDateAndPrice']);
    }

    List<BookDate>? convertedBookedDates;
    if (responseData['bookedDates'] != null) {
      convertedBookedDates = (responseData['bookedDates'] as List<dynamic>)
          .map((date) => BookDate.fromJson(date))
          .toList();
    }
    List<String>? convertedReviews = responseData['reviews'] != null
        ? List<String>.from(responseData['reviews'] as Iterable<dynamic>)
        : null;
    List<String>? convertedServices = responseData['services'] != null
        ? List<String>.from(responseData['services'] as Iterable<dynamic>)
        : null;
    List<String>? convertedImages = responseData['pictures'] != null
        ? List<String>.from(responseData['pictures'] as Iterable<dynamic>)
        : null;

    return Apartment(
      id: responseData['_id'],
      apartmentName: responseData['apartmentName'],
      description: responseData['description'],
      defaultDateAndPrice: defaultDateAndPrice,
      specialDates: responseData['specialDates'],
      bookedDates: convertedBookedDates ?? [],
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: convertedReviews,
      bedroom: responseData['bedroom'],
      bathroom: responseData['bathroom'],
      services: convertedServices,
      pictures: convertedImages,
      isWishlist: responseData['isWishlist'],
    );
  }

  factory Apartment.fromJsonWishList(Map<String, dynamic> responseData) {
    List<BookDate>? convertedBookedDates =
        (responseData['bookedDates'] as List<dynamic>)
            .map((date) => BookDate.fromJson(date))
            .toList();
    List<String>? convertedReviews = List<String>.from(responseData['reviews']);

    List<String>? convertedServices =
        List<String>.from(responseData['services']);
    List<String>? convertedImages = List<String>.from(responseData['pictures']);

    return Apartment(
      id: responseData['_id'],
      apartmentName: responseData['apartmentName'],
      description: responseData['description'],
      defaultDateAndPrice: responseData['defaultDateAndPrice'],
      specialDates: responseData['specialDates'],
      bookedDates: convertedBookedDates,
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: convertedReviews,
      bedroom: responseData['bedroom'],
      bathroom: responseData['bathroom'],
      services: convertedServices,
      pictures: convertedImages,
      isWishlist: responseData['isWishlist'],
    );
  }

  @override
  String toString() {
    return 'Apartment(id: $id, apartmentName: $apartmentName, description: $description, defaultDateAndPrice: $defaultDateAndPrice, specialDates: $specialDates, bookedDates: $bookedDates, location: $location, rooms: $rooms, sumOfRatings: $sumOfRatings, numOfRatings: $numOfRatings, rating: $rating, reviews: $reviews, bedroom: $bedroom,bathroom: $bathroom,services: $services, pictures: $pictures, FromDate: $FromDate, ToDate: $ToDate, isWishlist: $isWishlist)';
  }

  @override
  bool operator ==(covariant Apartment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.apartmentName == apartmentName &&
        other.description == description &&
        other.defaultDateAndPrice == defaultDateAndPrice &&
        other.specialDates == specialDates &&
        listEquals(other.bookedDates, bookedDates) &&
        other.location == location &&
        other.rooms == rooms &&
        other.sumOfRatings == sumOfRatings &&
        other.numOfRatings == numOfRatings &&
        other.rating == rating &&
        listEquals(other.reviews, reviews) &&
        other.bedroom == bedroom &&
        other.bathroom == bathroom &&
        listEquals(other.services, services) &&
        listEquals(other.pictures, pictures) &&
        other.FromDate == FromDate &&
        other.ToDate == ToDate &&
        other.isWishlist == isWishlist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        apartmentName.hashCode ^
        description.hashCode ^
        defaultDateAndPrice.hashCode ^
        specialDates.hashCode ^
        bookedDates.hashCode ^
        location.hashCode ^
        rooms.hashCode ^
        sumOfRatings.hashCode ^
        numOfRatings.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        bedroom.hashCode ^
        bathroom.hashCode ^
        services.hashCode ^
        pictures.hashCode ^
        FromDate.hashCode ^
        ToDate.hashCode ^
        isWishlist.hashCode;
  }
}
