import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final EdgeInsetsGeometry? margin;
  const CustomTitle(
      {super.key, required this.title, required this.fontSize, this.margin});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);
    return Container(
      margin: margin ?? const EdgeInsets.only(left: 15.0),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color.fromRGBO(45, 49, 54, 1),
          fontFamily: 'TT Commons',
          fontSize: fontSize * curScaleFactor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
