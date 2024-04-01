import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {super.key, this.text, this.backgroundColor, this.icon, this.textColor});

  final String? text;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          shadows: [
            BoxShadow(
              color: backgroundColor!.withOpacity(0.5),
              blurRadius: 3.5,
              spreadRadius: 2.0,
              offset: const Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: const Color.fromRGBO(246, 255, 230, 1),
              ),
            if (icon != null)
              const SizedBox(
                width: 12.0,
              ),
            Flexible(
              child: Text(
                text!,
                overflow: TextOverflow.clip,
                maxLines: 20,
                style: TextStyle(
                  color: textColor ?? const Color.fromRGBO(246, 255, 230, 1),
                  fontSize: 12.0 * curScaleFactor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
