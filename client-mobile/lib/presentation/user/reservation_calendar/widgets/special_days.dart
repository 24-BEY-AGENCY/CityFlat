import 'package:cityflat/presentation/shared/widgets/custom_icons2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/apartment_model.dart';

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

class SpecialDays extends StatelessWidget {
  final List<SpecialDate>? specialDates;
  const SpecialDays({super.key, required this.specialDates});

  List<SpecialDate> _generateFullSpecialDatesList() {
    List<SpecialDate> allDatePrices = [];
    DateTime today = DateTime.now();

    for (var specialDate in specialDates!) {
      if (specialDate.startDate != null && specialDate.endDate != null) {
        DateTime currentDate = specialDate.startDate!;
        DateTime endDate = specialDate.endDate!;

        currentDate = currentDate.isAfter(today) ? currentDate : today;

        while (
            currentDate.isBefore(endDate) || currentDate.isSameDate(endDate)) {
          allDatePrices.add(SpecialDate(
            startDate: currentDate,
            price: specialDate.price,
          ));
          currentDate = currentDate.add(const Duration(days: 1));
        }
      }
    }

    return allDatePrices;
  }

  String _formatDate(DateTime date) {
    final month = DateFormat.MMMM().format(date).toString();
    return '${date.day} $month, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Container(
      margin: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var date in _generateFullSpecialDatesList())
            Row(
              children: [
                const Icon(
                  CustomIcons2.calendar,
                  color: Color.fromRGBO(13, 178, 85, 1),
                  size: 15.0,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 30.0),
                  child: Text(
                    '${_formatDate(date.startDate!)} ',
                    style: TextStyle(
                      color: const Color.fromRGBO(45, 49, 54, 1),
                      fontSize: 15 * curScaleFactor,
                      fontFamily: 'TT Commons',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  '${date.price.toString()} €/ night',
                  style: TextStyle(
                    color: const Color.fromRGBO(13, 178, 84, 1),
                    fontSize: 16 * curScaleFactor,
                    fontFamily: 'TT Commons',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
