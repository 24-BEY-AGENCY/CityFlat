import 'package:cityflat/presentation/authentication/widgets/social_button.dart';
import 'package:flutter/material.dart';

import '../../../utilities/size_config.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    final onePercentOfWidth = SizeConfig.widthMultiplier;
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.black.withOpacity(0.7),
                  height: 1.0,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: onePercentOfWidth * 3),
                child: Text(
                  "Or",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w300,
                    fontSize: 16 * curScaleFactor,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black.withOpacity(0.7),
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: onePercentOfHeight * 3,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: onePercentOfWidth * 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SocialButton(
                  svgString: 'assets/logos/facebook.svg', height: 30.0),
              SocialButton(svgString: 'assets/logos/google.svg', height: 28.0),
              SocialButton(svgString: 'assets/logos/apple.svg', height: 28.0),
            ],
          ),
        ),
      ],
    );
  }
}
