import 'package:flutter/material.dart';

import '../models/apartment_model.dart';

class WishlistProvider extends ChangeNotifier {
  List<Apartment> _wishlists = [];

  List<Apartment> get wishlists => _wishlists;

  void setToWishlist(List<Apartment> wishlists) {
    _wishlists = wishlists;
  }

  void deleteFromWishlist(String deletedApartmentId) {
    _wishlists.removeWhere((apartment) => apartment.id == deletedApartmentId);
    notifyListeners();
  }
}
