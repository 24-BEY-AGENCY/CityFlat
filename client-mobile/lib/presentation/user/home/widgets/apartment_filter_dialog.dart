import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/apartment_provider.dart';
import '../../../shared/widgets/custom_alert_dialog.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../../shared/widgets/custom_light_neumorphic_elevated_button.dart';
import '../../../shared/widgets/custom_light_textformfield.dart';
import '../../../shared/widgets/custom_range_slider.dart';
import '../screens/filter_results_screen.dart';

class ApartmentFilterDialog extends StatelessWidget {
  ApartmentFilterDialog({
    super.key,
  });

  RangeValues? rangeValues = const RangeValues(0, 5000);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final apartmentProvider =
        Provider.of<ApartmentProvider>(context, listen: true);
    rangeValues = RangeValues(apartmentProvider.filterValues["min"]!,
        apartmentProvider.filterValues["max"]!);

    return CustomAlertDialog(
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.only(
              top: 20.0, left: 5.0, right: 5.0, bottom: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "FILTER",
                  style: TextStyle(
                    color: const Color.fromRGBO(45, 49, 54, 1),
                    fontSize: 23 * curScaleFactor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'TT Commons',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  "PRICE RANGE",
                  style: TextStyle(
                    fontFamily: 'TT Commons',
                    fontSize: 12.0 * curScaleFactor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: const Color.fromRGBO(26, 27, 26, 1),
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const CustomLightTextFormField(
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0),
                    intensity: 1,
                    customTextInputAction: TextInputAction.next,
                    customKeyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    readOnly: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 10.0),
                    child: CustomRangeSlider(
                      min: apartmentProvider.filterValues["min"],
                      max: apartmentProvider.filterValues["max"],
                      currentRangeValues: rangeValues,
                      onChanged: (value) {
                        setState(() {
                          rangeValues = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: CustomLightElevatedButton(
                  buttonText: "FILTER",
                  shadows: const [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      blurRadius: 5.2,
                      spreadRadius: 0.0,
                      offset: Offset(-4.0, -4.0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      blurRadius: 5.2,
                      spreadRadius: 0.0,
                      offset: Offset(-4.0, -4.0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(231, 231, 231, 71),
                      blurRadius: 3.5,
                      spreadRadius: 0.0,
                      offset: Offset(5.0, 4.0),
                    ),
                  ],
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(2, 129, 57, 1),
                        Color.fromRGBO(7, 210, 95, 1)
                      ]),
                  textColor: const Color.fromRGBO(255, 255, 255, 1),
                  onPressed: () async {
                    Navigator.of(context).pushNamed(
                        FilterResultsScreen.routeName,
                        arguments: {"rangeValues": rangeValues});
                  },
                  condition: true,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 40.0),
                child: CustomLightNeumrphicElevatedButton(
                  buttonText: "CANCEL",
                  border: Border.all(
                    color: const Color.fromRGBO(13, 178, 84, 1),
                    width: 1,
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      blurRadius: 5.2,
                      spreadRadius: 0.0,
                      offset: Offset(-4.0, -4.0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      blurRadius: 5.2,
                      spreadRadius: 0.0,
                      offset: Offset(-4.0, -4.0),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(231, 231, 231, 0.71),
                      blurRadius: 3.5,
                      spreadRadius: 0.0,
                      offset: Offset(5.0, 4.0),
                    ),
                  ],
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  textColor: const Color.fromRGBO(13, 178, 84, 1),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  condition: true,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
