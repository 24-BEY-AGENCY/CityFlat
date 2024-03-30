import 'package:flutter/material.dart';

import '../../../../models/service_model.dart';
import '../../../../utilities/size_config.dart';

class ReservationDetailsServices extends StatelessWidget {
  final List<Service>? services;

  const ReservationDetailsServices({super.key, this.services});

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
      children: [
        textBuilder(
            text: "Services :", fontSize: 16, fontWeight: FontWeight.w600),
        SizedBox(width: onePercentOfWidth * 16),
        SizedBox(
          width: onePercentOfWidth * 50,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var service in services!)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        Icon(
                          service.icon,
                          color: const Color.fromRGBO(188, 188, 188, 1),
                          size: service.name == "Rent" ? 12.0 : 20.0,
                        ),
                        SizedBox(
                          width: service.name == "Rent" ? 19.0 : 13.0,
                        ),
                        textBuilder(
                            text: service.name!,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
