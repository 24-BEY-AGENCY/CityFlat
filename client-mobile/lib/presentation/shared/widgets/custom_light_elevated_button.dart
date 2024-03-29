import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CustomLightElevatedButton extends StatelessWidget {
  final String buttonText;
  final double? fontSize;
  final void Function()? onPressed;
  final bool? condition;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final Color? color;
  final Color? textColor;
  final BoxBorder? border;
  final bool? buttonIcon;
  final EdgeInsetsGeometry? margin;
  final Widget? icon;

  const CustomLightElevatedButton({
    super.key,
    required this.buttonText,
    this.fontSize,
    this.onPressed,
    this.condition,
    this.shadows,
    this.gradient,
    this.color,
    this.textColor,
    this.border,
    this.buttonIcon,
    this.margin,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        shadows: shadows,
      ),
      child: MaterialButton(
        onPressed: condition == true ? onPressed! : null,
        textColor:
            condition! ? textColor : const Color.fromRGBO(255, 255, 255, 0.2),
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
            color: color ?? null,
            gradient: gradient ?? null,
            borderRadius: BorderRadius.circular(30.0),
            border: border ?? null,
          ),
          child: Container(
              height: 62,
              constraints:
                  const BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
              alignment: Alignment.center,
              child: buttonIcon != null
                  ? Text(
                      buttonText,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: fontSize ?? 18.0 * curScaleFactor,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon ??
                            const Icon(
                              CustomIcons.filter,
                              color: Colors.white,
                              size: 20.0,
                            ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          buttonText,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize ?? 18.0 * curScaleFactor,
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
