import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  const CustomBackButton({super.key, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return IconButton(
      icon: Icon(
        CustomIcons.arrow_left,
        size: 13 * curScaleFactor,
      ),
      color: color,
      onPressed: onPressed,
    );
  }
}
