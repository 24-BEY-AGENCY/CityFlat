import 'package:cityflat/models/apartment_model.dart';
import 'package:flutter/material.dart';

class ApartmentProvider extends ChangeNotifier {
  List<Apartment> _apartments = [];
  Map<String, double>? _filterValues;

  List<Apartment> get apartments => _apartments;
  Map<String, double> get filterValues => _filterValues!;

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
    print(_apartments);
    notifyListeners();
  }

  void deleteApartment(String deletedApartmentId) {
    _apartments.removeWhere((apartment) => apartment.id == deletedApartmentId);
    notifyListeners();
  }

  setFilterValues(Map<String, double> filterValues) {
    _filterValues = filterValues;
    notifyListeners();
  }
}
