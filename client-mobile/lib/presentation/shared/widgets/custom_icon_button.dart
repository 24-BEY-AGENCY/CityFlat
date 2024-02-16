import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final List<Color>? gradientColors;
  final double? width;
  final double? height;
  final double? iconSize;

  const CustomIconButton(
      {Key? key,
      this.icon,
      this.onPressed,
      this.gradientColors,
      this.width,
      this.height,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
