import 'package:cityflat/presentation/shared/widgets/custom_icons2.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/custom_alert_dialog.dart';
import '../../../shared/widgets/custom_light_elevated_button.dart';
import '../../user_wrapper/user_wrapper.dart';

class ReservationReviewedDialog extends StatelessWidget {
  const ReservationReviewedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return CustomAlertDialog(
      contentPadding: EdgeInsets.zero,
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.only(
              top: 50.0, left: 5.0, right: 5.0, bottom: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                CustomIcons2.loading,
                size: 65 * curScaleFactor,
                color: const Color.fromRGBO(13, 178, 84, 1),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Your Request Is Currently Being Consulted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromRGBO(45, 49, 54, 1),
                    fontSize: 30 * curScaleFactor,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'TT Commons',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                child: CustomLightElevatedButton(
                    buttonText: "OK!",
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
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(UserWrapper.routeName);
                    },
                    condition: true,
                    buttonIcon: false),
              ),
            ],
          ),
        );
      }),
    );
  }
}
