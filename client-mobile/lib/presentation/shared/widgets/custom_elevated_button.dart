import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.buttonText,
      this.fontSize,
      this.onPressed,
      this.condition});

  final String buttonText;
  final double? fontSize;
  final void Function()? onPressed;
  final bool? condition;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        shadows: const [
          BoxShadow(
            color: Color.fromRGBO(47, 52, 60, 57),
            blurRadius: 4.6,
            spreadRadius: 0.0,
            offset: Offset(-6, -7.0),
          ),
          BoxShadow(
            color: Color.fromRGBO(28, 31, 35, 77),
            blurRadius: 3.5,
            spreadRadius: 0.0,
            offset: Offset(6, 7.0),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: condition == true ? onPressed! : null,
        textColor: condition!
            ? const Color.fromRGBO(255, 255, 255, 1)
            : const Color.fromRGBO(255, 255, 255, 0.2),
        disabledTextColor: const Color.fromRGBO(255, 255, 255, 0.1),
        disabledColor: const Color.fromRGBO(255, 255, 255, 0.1),
        splashColor: const Color.fromRGBO(2, 129, 57, 1),
        highlightColor: const Color.fromRGBO(2, 129, 57, 0.7),
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Ink(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: condition!
                    ? [
                        const Color.fromRGBO(2, 129, 57, 1),
                        const Color.fromRGBO(7, 210, 95, 1)
                      ]
                    : [
                        const Color.fromRGBO(2, 129, 57, 0.1),
                        const Color.fromRGBO(7, 210, 95, 0.1)
                      ]),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
              height: 62,
              constraints:
                  const BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0 * curScaleFactor,
                ),
              )),
        ),
      ),
    );
  }
}
