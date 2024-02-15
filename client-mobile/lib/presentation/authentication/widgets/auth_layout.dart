import 'package:flutter/material.dart';
import '../../../utilities/size_config.dart';
import '../../shared/widgets/gradient_scaffold.dart';

class AuthLayout extends StatelessWidget {
  final String? pageTitle;
  final Widget? pageChild;

  const AuthLayout({super.key, this.pageTitle, this.pageChild});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;
    final keyboardHeight = mediaQuery.viewInsets.bottom;
    final onePercentOfHeight = SizeConfig.heightMultiplier;

    bool keyboardIsVisible() {
      return !(keyboardHeight == 0.0);
    }

    return GradientScaffold(
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(25, 26, 30, 1),
          Color.fromRGBO(22, 24, 31, 1),
          Color.fromRGBO(22, 24, 31, 1),
          Color.fromRGBO(22, 24, 31, 1),
          Color.fromRGBO(43, 48, 52, 1),
          Color.fromRGBO(45, 50, 54, 1),
        ],
        stops: [0.3, 0.5, 0.6, 0.7, 0.99, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(25, 26, 30, 0.8),
              Color.fromRGBO(22, 24, 31, 0.775),
              Color.fromRGBO(25, 28, 34, 0.0),
              Color.fromRGBO(40, 44, 48, 0.0)
            ],
            stops: [0.2, 0.3, 0.4, 1],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  if (!keyboardIsVisible())
                    Image.asset(
                      "assets/images/background_image.png",
                      width: double.infinity,
                      height: onePercentOfHeight * 35,
                      fit: BoxFit.cover,
                    ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: onePercentOfHeight * 6),
                    child: Column(
                      children: [
                        if (!keyboardIsVisible())
                          Image.asset(
                            "assets/cityflat_logo/cityflat_logo.png",
                            width: 50.0,
                            fit: BoxFit.fitHeight,
                          ),
                        if (!keyboardIsVisible()) const SizedBox(height: 10.0),
                        if (!keyboardIsVisible())
                          Image.asset(
                            "assets/cityflat_logo/cityflat_logo_text.png",
                            width: 100.0,
                            fit: BoxFit.fitHeight,
                          ),
                        if (!keyboardIsVisible())
                          Container(
                            margin: EdgeInsets.only(
                              top: onePercentOfHeight * 4,
                            ),
                            alignment: Alignment.topCenter,
                            child: Text(
                              pageTitle!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 25.0 * curScaleFactor,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                        SizedBox(
                          height: onePercentOfHeight * 5,
                        ),
                        pageChild!,
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
