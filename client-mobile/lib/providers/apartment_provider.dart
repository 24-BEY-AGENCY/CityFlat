import 'package:cityflat/models/apartment_model.dart';
import 'package:flutter/material.dart';

class ApartmentProvider extends ChangeNotifier {
  List<Apartment> _apartments = [];
  List<Apartment> _favoriteApartments = [];
  Map<String, double>? _filterValues;

  Apartment? _oneApartment;

  List<Apartment> get apartments => _apartments;
  List<Apartment> get favoriteApartments => _favoriteApartments;
  Apartment? get oneApartment => _oneApartment;

  Map<String, double> get filterValues => _filterValues!;

  void setOneApartment(Apartment apartment) {
    _oneApartment = apartment;
  }

  void setApartments(List<Apartment> apartments) {
    _apartments = apartments;
  }

  void addApartment(Apartment newApartment) {
    _apartments.add(newApartment);
    notifyListeners();
  }

  void updateApartment(Apartment updatedApartment) {
    int index = _apartments
        .indexWhere((apartment) => apartment.id == updatedApartment.id);
    if (index != -1) {
      _apartments[index] = updatedApartment;
      notifyListeners();
    }
  }

  void switchApartmentFav(Apartment updatedApartment) {
    int index = _apartments
        .indexWhere((apartment) => apartment.id == updatedApartment.id);
    if (index != -1) {
      _apartments[index].isWishlist = !apartments[index].isWishlist!;
      notifyListeners();
    }
  }

  void fillWishListProperty(Apartment updatedApartment) {
    int index = _apartments
        .indexWhere((apartment) => apartment.id == updatedApartment.id);
    if (index != -1) {
      _apartments[index] = updatedApartment;
    }
  }

  switchWishList(String id) {
    Apartment apartment =
        _apartments.firstWhere((apartment) => apartment.id == id);
    apartment.isWishlist = !apartment.isWishlist!;
    notifyListeners();
  }

  void deleteApartment(String deletedApartmentId) {
    _apartments.removeWhere((apartment) => apartment.id == deletedApartmentId);
    notifyListeners();
  }

  void setFavoriteApartments(List<Apartment> apartments) {
    _favoriteApartments
        .addAll(apartments.where((apartment) => apartment.isWishlist!));

    _favoriteApartments = favoriteApartments;
  }

  void addFavoriteApartment(Apartment newApartment) {
    _favoriteApartments.add(newApartment);
    notifyListeners();
  }

  void deleteFavoriteApartment(String deletedApartmentId) {
    _favoriteApartments
        .removeWhere((apartment) => apartment.id == deletedApartmentId);
    notifyListeners();
  }

  switchFavoriteWishList(String id) {
    try {
      Apartment apartment = _favoriteApartments.firstWhere(
        (apartment) => apartment.id == id,
        orElse: () => Apartment(),
      );

      if (apartment.id == null) {
        apartment = _apartments.firstWhere((apartment) => apartment.id == id);
        _favoriteApartments.add(apartment);
      } else {
        _favoriteApartments.remove(apartment);
      }
    } catch (e) {
      return;
    }
    notifyListeners();
  }

  setFilterValues(Map<String, double> filterValues) {
    _filterValues = filterValues;
    notifyListeners();
  }
}
