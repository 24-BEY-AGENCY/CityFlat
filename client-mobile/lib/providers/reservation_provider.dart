import 'package:cityflat/models/reservation_model.dart';
import 'package:flutter/material.dart';

class ReservationProvider extends ChangeNotifier {
  List<Reservation> _reservations = [];
  DateTime? _rangeStartDate;
  DateTime? _rangeEndDate;

  List<Reservation> get reservations => _reservations;

  DateTime? get rangeStartDate => _rangeStartDate;
  DateTime? get rangeEndDate => _rangeEndDate;

  void setReservations(List<Reservation> reservations) {
    _reservations = reservations;
  }

  void addReservation(Reservation newReservation) {
    _reservations.add(newReservation);
    notifyListeners();
  }

  setStartEndDates(DateTime rangeStartDate, DateTime rangeEndDate) {
    _rangeStartDate = rangeStartDate;
    _rangeEndDate = rangeEndDate;
    notifyListeners();
  }
}
