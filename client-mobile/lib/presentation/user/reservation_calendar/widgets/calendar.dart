import 'package:cityflat/providers/reservation_provider.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../models/apartment_model.dart';
import '../../../../models/book_date_model.dart';

class Calendar extends StatefulWidget {
  final List<BookDate> bookedDates;
  final List<SpecialDate> specialDates;
  const Calendar(
      {super.key, required this.bookedDates, required this.specialDates});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  final DateTime _firstDay = DateTime.now();
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 365 * 2));
  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDay;

  DateTime? _rangeStart;

  DateTime? _rangeEnd;

  bool _isDateDisabled(DateTime date) {
    for (var bookDate in widget.bookedDates) {
      if (date.isAfter(bookDate.start!) && date.isBefore(bookDate.end!) ||
          date.isAtSameMomentAs(bookDate.start!) ||
          date.isAtSameMomentAs(bookDate.end!)) {
        return true;
      }
    }
    return false;
  }

  bool _isSpecialDay(DateTime date) {
    for (var bookDate in widget.specialDates) {
      if (date.isAfter(bookDate.startDate!) &&
              date.isBefore(bookDate.endDate!) ||
          date.isAtSameMomentAs(bookDate.startDate!) ||
          date.isAtSameMomentAs(bookDate.endDate!)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final reservationProvider =
        Provider.of<ReservationProvider>(context, listen: false);

    return TableCalendar(
      availableGestures: AvailableGestures.horizontalSwipe,
      startingDayOfWeek: StartingDayOfWeek.monday,
      firstDay: _firstDay,
      lastDay: _lastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      enabledDayPredicate: (date) => !_isDateDisabled(date),
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null;
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
        });
        reservationProvider.setStartEndDates(
            _rangeStart!, _rangeEnd ?? _rangeStart!);
      },
      onPageChanged: (focusedDay) {
        setState(() {});
        _focusedDay = focusedDay;
      },
      headerStyle: HeaderStyle(
        titleTextFormatter: (DateTime day, dynamic locale) {
          final month = DateFormat.MMMM(locale).format(day).toString();

          return "${month[0].toUpperCase()}${month.substring(1)}, ${day.year}";
        },
        formatButtonVisible: false,
        headerMargin: const EdgeInsets.only(bottom: 1.0),
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: const Color.fromRGBO(45, 49, 54, 1),
          fontSize: 22 * curScaleFactor,
          fontFamily: 'TT Commons',
          fontWeight: FontWeight.w700,
        ),
        leftChevronIcon: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(105, 119, 111, 0.1),
          ),
          child: Icon(
            Icons.chevron_left_rounded,
            color: _focusedDay.month <= _firstDay.month &&
                    _focusedDay.year <= _firstDay.year
                ? const Color.fromRGBO(0, 0, 0, 0.1)
                : const Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
        rightChevronIcon: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(105, 119, 111, 0.1),
          ),
          child: Icon(
            Icons.chevron_right_rounded,
            color: _focusedDay.month >= _lastDay.month &&
                    _focusedDay.year >= _lastDay.year
                ? const Color.fromRGBO(0, 0, 0, 0.1)
                : const Color.fromRGBO(0, 0, 0, 0.3),
          ),
        ),
      ),
      daysOfWeekHeight: 30.0,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) =>
            DateFormat.E(locale).format(date)[0].toUpperCase(),
        weekdayStyle: const TextStyle(color: Color.fromRGBO(159, 159, 159, 1)),
        weekendStyle: const TextStyle(color: Color.fromRGBO(159, 159, 159, 1)),
      ),
      rowHeight: 45.0,
      calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false,
          defaultTextStyle: TextStyle(
            color: const Color.fromRGBO(45, 49, 54, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          weekendTextStyle: TextStyle(
            color: const Color.fromRGBO(45, 49, 54, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          selectedDecoration: const BoxDecoration(
            color: Color.fromRGBO(45, 49, 54, 1),
            shape: BoxShape.circle,
          ),
          selectedTextStyle: TextStyle(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          rangeStartTextStyle: TextStyle(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          withinRangeTextStyle: TextStyle(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          rangeEndTextStyle: TextStyle(
            color: const Color.fromRGBO(255, 255, 255, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w600,
          ),
          rangeStartDecoration: _rangeEnd != null
              ? const BoxDecoration()
              : const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(2, 129, 57, 1),
                      Color.fromRGBO(7, 210, 95, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle),
          rangeEndDecoration: const BoxDecoration(),
          disabledTextStyle: TextStyle(
            color: const Color.fromRGBO(188, 188, 188, 1),
            fontSize: 16 * curScaleFactor,
            fontFamily: 'TT Commons',
            fontWeight: FontWeight.w400,
          )),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          if (_isSpecialDay(date)) {
            return Container(
              margin: const EdgeInsets.only(
                  left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(13, 178, 84, 1),
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: const Color.fromRGBO(45, 49, 54, 1),
                  fontSize: 16 * curScaleFactor,
                  fontFamily: 'TT Commons',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return null;
          }
        },
        rangeHighlightBuilder: (context, day, isWithinRange) {
          return (isWithinRange && day.weekday == DateTime.monday) ||
                  (isWithinRange && day == _rangeStart)
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: SmoothBorderRadius.only(
                      topLeft: const SmoothRadius(
                        cornerRadius: 50,
                        cornerSmoothing: 1,
                      ),
                      bottomLeft: const SmoothRadius(
                        cornerRadius: 50,
                        cornerSmoothing: 1,
                      ),
                      topRight: (isWithinRange &&
                              ((day == _rangeStart &&
                                      day.weekday == DateTime.sunday) ||
                                  (day == _rangeEnd &&
                                      day.weekday == DateTime.monday)))
                          ? const SmoothRadius(
                              cornerRadius: 50,
                              cornerSmoothing: 1,
                            )
                          : SmoothRadius.zero,
                      bottomRight: (isWithinRange &&
                              ((day == _rangeStart &&
                                      day.weekday == DateTime.sunday) ||
                                  (day == _rangeEnd)))
                          ? const SmoothRadius(
                              cornerRadius: 50,
                              cornerSmoothing: 1,
                            )
                          : SmoothRadius.zero,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(2, 129, 57, 1),
                        Color.fromRGBO(7, 210, 95, 1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: (_isSpecialDay(day))
                      ? Container(
                          margin: const EdgeInsets.only(
                              left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        )
                      : null,
                )
              : ((isWithinRange && day.weekday == DateTime.sunday) ||
                      (isWithinRange && day == _rangeEnd))
                  ? Container(
                      decoration: const BoxDecoration(
                        borderRadius: SmoothBorderRadius.only(
                          bottomRight: SmoothRadius(
                            cornerRadius: 50,
                            cornerSmoothing: 1,
                          ),
                          topRight: SmoothRadius(
                            cornerRadius: 50,
                            cornerSmoothing: 1,
                          ),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(2, 129, 57, 1),
                            Color.fromRGBO(7, 210, 95, 1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: _isSpecialDay(day)
                          ? Container(
                              margin: const EdgeInsets.only(
                                  left: 6.0, right: 6.0, top: 4.0, bottom: 4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            )
                          : null,
                    )
                  : (isWithinRange
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.transparent, width: 0.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(2, 129, 57, 1),
                                Color.fromRGBO(7, 210, 95, 1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: (_isSpecialDay(day))
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      left: 6.0,
                                      right: 6.0,
                                      top: 4.0,
                                      bottom: 4.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                )
                              : null,
                        )
                      : Container());
        },
      ),
    );
  }
}
