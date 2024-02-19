import 'dart:ui';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key, this.title, this.content, this.actions, this.contentPadding});

  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: AlertDialog(
        content: Container(decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.circular(50.0),
            ),
        child:
        
        Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(169, 169, 169, 0.27),
                  Color.fromRGBO(255, 255, 255, 0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: content),),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 4,
        titleTextStyle: TextStyle(
          color: const Color.fromRGBO(45, 49, 54, 1),
          fontSize: 23 * curScaleFactor,
          fontWeight: FontWeight.w700,
          fontFamily: 'TT Commons',
        ),
        contentTextStyle: TextStyle(
          color: const Color.fromRGBO(26, 27, 26, 1),
          fontSize: 12 * curScaleFactor,
          fontWeight: FontWeight.w500,
          fontFamily: 'TT Commons',
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsOverflowDirection: VerticalDirection.down,
        contentPadding: contentPadding ??
            const EdgeInsets.only(
                top: 20.0, left: 5.0, right: 5.0, bottom: 10.0),
      ),
    );
  }
}
