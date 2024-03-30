import 'package:cityflat/models/apartment_model.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_icons.dart';

class OneAapartmentInfo extends StatelessWidget {
  final Apartment? apartment;
  final double? marginTop1;
  final double? marginbottom;
  final bool? isDescription;
  const OneAapartmentInfo(
      {super.key,
      this.apartment,
      this.marginTop1,
      this.marginbottom,
      this.isDescription});

  Widget iconTextBuilder(
      {EdgeInsetsGeometry? margin, IconData? icon, Text? text}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: margin,
          child: Icon(
            icon!,
            color: const Color.fromRGBO(222, 194, 95, 1),
            size: 14.0,
          ),
        ),
        text!,
      ],
    );
  }

  Widget accomodationBuilder(
      {Widget? icon, String? textRegular, String? textBold}) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(right: 5.0),
              decoration: ShapeDecoration(
                color: const Color.fromRGBO(13, 178, 84, 0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 15,
                    cornerSmoothing: 1,
                  ),
                ),
              ),
              child: icon!),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textRegular!,
                style: const TextStyle(
                  fontFamily: 'TT Commons',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(45, 49, 54, 1),
                  overflow: TextOverflow.visible,
                  height: 1.0,
                ),
              ),
              Text(
                textBold!,
                style: const TextStyle(
                  fontFamily: 'TT Commons',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(45, 49, 54, 1),
                  overflow: TextOverflow.visible,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.0, top: marginTop1!, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              iconTextBuilder(
                margin: const EdgeInsets.only(right: 5.0),
                icon: CustomIcons.location,
                text: Text(
                  apartment!.location!,
                  style: TextStyle(
                    fontFamily: 'TT Commons',
                    fontSize: 16.0 * curScaleFactor,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(38, 41, 48, 1),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                child: iconTextBuilder(
                  margin: const EdgeInsets.only(right: 5.0),
                  icon: CustomIcons.star,
                  text: Text(
                    apartment!.rating!.toString(),
                    style: TextStyle(
                      fontFamily: 'TT Commons',
                      fontSize: 17.5 * curScaleFactor,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: marginbottom!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              accomodationBuilder(
                  icon: Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: const Icon(
                      CustomIcons.bedroom,
                      color: Color.fromRGBO(13, 178, 84, 1),
                      size: 18.0,
                    ),
                  ),
                  textRegular: "Bedroom",
                  textBold: "${apartment!.bedroom!} Rooms"),
              accomodationBuilder(
                  icon: const Icon(
                    CustomIcons.bath,
                    color: Color.fromRGBO(13, 178, 84, 1),
                    size: 20.0,
                  ),
                  textRegular: "Bathroom",
                  textBold: "${apartment!.bathroom!}  Rooms"),
            ],
          ),
        ),
        if (isDescription!)
          Text(
            "Description :",
            style: TextStyle(
              fontFamily: 'TT Commons',
              fontSize: 20.0 * curScaleFactor,
              fontWeight: FontWeight.w700,
              color: const Color.fromRGBO(45, 49, 54, 1),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 20.0),
          child: Text(
            apartment!.description!,
            style: TextStyle(
              fontFamily: 'TT Commons',
              fontSize: 16.0 * curScaleFactor,
              fontWeight: FontWeight.w400,
              color: const Color.fromRGBO(132, 137, 152, 1),
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}
