import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/apartment_model.dart';
import '../../../../utilities/size_config.dart';
import '../../../shared/widgets/custom_icons2.dart';

class ReservationDetailsCalendar extends StatelessWidget {
  final List<SpecialDate>? dates;

  const ReservationDetailsCalendar({super.key, this.dates});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfWidth = SizeConfig.widthMultiplier;

    Widget textBuilder(
        {String? text, double? fontSize, FontWeight? fontWeight}) {
      return Text(
        text!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color.fromRGBO(45, 49, 54, 1),
          fontFamily: 'TT Commons',
          fontSize: fontSize! * curScaleFactor,
          fontWeight: fontWeight,
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        textBuilder(
            text: "Calendar :", fontSize: 16, fontWeight: FontWeight.w600),
        SizedBox(
          width: (onePercentOfWidth * 16 - 2.0),
        ),
        Container(
          child: Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        CustomIcons2.calendar,
                        color: Color.fromRGBO(188, 188, 188, 1),
                        size: 15.0,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        child: Flexible(
                          child: Container(
                            child: textBuilder(
                                text:
                                    "${DateFormat('MM/dd/yyyy').format(dates!.first.startDate!).toString()}${dates!.first.startDate != dates!.last.startDate ? ' To ${DateFormat('MM/dd/yyyy').format(dates!.last.startDate!)}' : ''}",
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: textBuilder(
                                text: "Nights :  ",
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: textBuilder(
                                text: dates!.length.toString(),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
