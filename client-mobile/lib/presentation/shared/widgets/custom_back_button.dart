import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onPressed;
  const CustomBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor;

    return IconButton(
      icon: Icon(
        CustomIcons.arrow_left,
        size: 13 * curScaleFactor,
      ),
      onPressed: onPressed,
    );
  }
}
