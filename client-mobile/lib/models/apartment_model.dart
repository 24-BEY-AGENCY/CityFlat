import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:cityflat/models/review_model.dart';

import 'book_date_model.dart';
import 'price_per_night_model.dart';

class Apartment {
  String? id;
  String? name;
  String? description;
  num? defaultPrice;
  List<PricePerNight>? pricePerNight;
  List<BookDate>? bookedDates;
  String? location;
  num? rooms;
  num? sumOfRatings;
  num? numOfRatings;
  num? rating;
  List<dynamic>? reviews;
  List<String>? services;
  List<dynamic>? img;
  DateTime? FromDate;
  DateTime? ToDate;
  bool? isWishlist;
  Apartment({
    this.id,
    this.name,
    this.description,
    this.defaultPrice,
    this.pricePerNight,
    this.bookedDates,
    this.location,
    this.rooms,
    this.sumOfRatings,
    this.numOfRatings,
    this.rating,
    this.reviews,
    this.services,
    this.img,
    this.FromDate,
    this.ToDate,
    this.isWishlist,
  });

  Apartment copyWith({
    String? id,
    String? name,
    String? description,
    num? defaultPrice,
    List<PricePerNight>? pricePerNight,
    List<BookDate>? bookedDates,
    String? location,
    num? rooms,
    num? sumOfRatings,
    num? numOfRatings,
    num? rating,
    List<dynamic>? reviews,
    List<String>? services,
    List<dynamic>? img,
    DateTime? FromDate,
    DateTime? ToDate,
    bool? isWishlist,
  }) {
    return Apartment(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      bookedDates: bookedDates ?? this.bookedDates,
      location: location ?? this.location,
      rooms: rooms ?? this.rooms,
      sumOfRatings: sumOfRatings ?? this.sumOfRatings,
      numOfRatings: numOfRatings ?? this.numOfRatings,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      services: services ?? this.services,
      img: img ?? this.img,
      FromDate: FromDate ?? this.FromDate,
      ToDate: ToDate ?? this.ToDate,
      isWishlist: isWishlist ?? this.isWishlist,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'defaultPrice': defaultPrice,
      'pricePerNight': pricePerNight,
      // 'bookedDates': bookedDates!.map((x) => x?.toMap()).toList(),
      'location': location,
      'rooms': rooms,
      'sumOfRatings': sumOfRatings,
      'numOfRatings': numOfRatings,
      'rating': rating,
      'reviews': reviews,
      'services': services,
      'img': img,
      'FromDate': FromDate?.millisecondsSinceEpoch,
      'ToDate': ToDate?.millisecondsSinceEpoch,
      'isWishlist': isWishlist,
    };
  }

  factory Apartment.fromMap(Map<String, dynamic> map) {
    return Apartment(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      defaultPrice:
          map['defaultPrice'] != null ? map['defaultPrice'] as num : null,
      // bookedDates: map['bookedDates'] != null ? List<BookDate>.from((map['bookedDates'] as List<int>).map<BookDate?>((x) => BookDate.fromMap(x as Map<String,dynamic>),),) : null,
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
      services: map['services'] != null
          ? List<String>.from((map['services'] as List<String>))
          : null,
      img: map['img'] != null
          ? List<dynamic>.from((map['img'] as List<dynamic>))
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
    List<PricePerNight>? convertedPricePerNight;

    if (responseData['pricePerNight'] != null) {
      convertedPricePerNight = (responseData['pricePerNight'] as List<dynamic>)
          .map((date) => PricePerNight.fromJson(date))
          .toList();
    }

    List<BookDate>? convertedBookedDates =
        (responseData['bookedDates'] as List<dynamic>)
            .map((date) => BookDate.fromJson(date))
            .toList();
    List<Review>? convertedReviews = (responseData['reviews'] as List<dynamic>)
        .map((review) => Review.fromJson(review))
        .toList();
    List<String>? convertedServices =
        List<String>.from(responseData['services']);
    List<String>? convertedImages = List<String>.from(responseData['img']);

    return Apartment(
      id: responseData['_id'],
      name: responseData['name'],
      description: responseData['description'],
      defaultPrice: responseData['defaultPrice'],
      pricePerNight: convertedPricePerNight,
      bookedDates: convertedBookedDates,
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: convertedReviews,
      services: convertedServices,
      img: convertedImages,
      isWishlist: responseData['isWishlist'],
    );
  }
  factory Apartment.fromJsonSearch(Map<String, dynamic> responseData) {
    List<PricePerNight>? convertedPricePerNight =
        (responseData['pricePerNight'] as List<dynamic>)
            .map((date) => PricePerNight.fromJson(date))
            .toList();
    List<BookDate>? convertedBookedDates =
        (responseData['bookedDates'] as List<dynamic>)
            .map((date) => BookDate.fromJson(date))
            .toList();
    List<String>? convertedReviews = List<String>.from(responseData['reviews']);
    List<String>? convertedServices =
        List<String>.from(responseData['services']);
    List<String>? convertedImages = List<String>.from(responseData['img']);

    return Apartment(
      id: responseData['id'],
      name: responseData['name'],
      description: responseData['description'],
      defaultPrice: responseData['defaultPrice'],
      pricePerNight: convertedPricePerNight,
      bookedDates: convertedBookedDates,
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: convertedReviews,
      services: convertedServices,
      img: convertedImages,
      isWishlist: responseData['isWishlist'],
    );
  }

  factory Apartment.fromJsonWishList(Map<String, dynamic> responseData) {
    List<PricePerNight>? convertedPricePerNight =
        (responseData['pricePerNight'] as List<dynamic>)
            .map((date) => PricePerNight.fromJson(date))
            .toList();
    List<BookDate>? convertedBookedDates =
        (responseData['bookedDates'] as List<dynamic>)
            .map((date) => BookDate.fromJson(date))
            .toList();
    List<String>? convertedReviews = List<String>.from(responseData['reviews']);

    List<String>? convertedServices =
        List<String>.from(responseData['services']);
    List<String>? convertedImages = List<String>.from(responseData['img']);

    return Apartment(
      id: responseData['_id'],
      name: responseData['name'],
      description: responseData['description'],
      defaultPrice: responseData['defaultPrice'],
      pricePerNight: convertedPricePerNight,
      bookedDates: convertedBookedDates,
      location: responseData['location'],
      rooms: responseData['rooms'],
      sumOfRatings: responseData['sumOfRatings'],
      numOfRatings: responseData['numOfRatings'],
      rating: responseData['rating'],
      reviews: convertedReviews,
      services: convertedServices,
      img: convertedImages,
      isWishlist: responseData['isWishlist'],
    );
  }

  @override
  String toString() {
    return 'Apartment(id: $id, name: $name, description: $description, defaultPrice: $defaultPrice, pricePerNight: $pricePerNight, bookedDates: $bookedDates, location: $location, rooms: $rooms, sumOfRatings: $sumOfRatings, numOfRatings: $numOfRatings, rating: $rating, reviews: $reviews, services: $services, img: $img, FromDate: $FromDate, ToDate: $ToDate, isWishlist: $isWishlist)';
  }

  @override
  bool operator ==(covariant Apartment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.defaultPrice == defaultPrice &&
        other.pricePerNight == pricePerNight &&
        listEquals(other.bookedDates, bookedDates) &&
        other.location == location &&
        other.rooms == rooms &&
        other.sumOfRatings == sumOfRatings &&
        other.numOfRatings == numOfRatings &&
        other.rating == rating &&
        listEquals(other.reviews, reviews) &&
        listEquals(other.services, services) &&
        listEquals(other.img, img) &&
        other.FromDate == FromDate &&
        other.ToDate == ToDate &&
        other.isWishlist == isWishlist;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        defaultPrice.hashCode ^
        pricePerNight.hashCode ^
        bookedDates.hashCode ^
        location.hashCode ^
        rooms.hashCode ^
        sumOfRatings.hashCode ^
        numOfRatings.hashCode ^
        rating.hashCode ^
        reviews.hashCode ^
        services.hashCode ^
        img.hashCode ^
        FromDate.hashCode ^
        ToDate.hashCode ^
        isWishlist.hashCode;
  }
}
