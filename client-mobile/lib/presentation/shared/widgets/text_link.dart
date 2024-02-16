import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink({Key? key, this.text, this.textLink, this.onTap})
      : super(key: key);

  final String? text;
  final String? textLink;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: 'TT Commons',
              fontWeight: FontWeight.w500,
              fontSize: 14 * curScaleFactor,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                  text: textLink,
                  style: TextStyle(
                    fontFamily: 'TT Commons',
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * curScaleFactor,
                    color: const Color.fromRGBO(27, 230, 115, 1),
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTap),
            ],
          ),
        ),
      ),
    );
  }
}
