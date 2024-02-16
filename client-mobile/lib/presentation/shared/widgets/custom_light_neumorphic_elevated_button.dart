import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomLightNeumrphicElevatedButton extends StatelessWidget {
  const CustomLightNeumrphicElevatedButton(
      {super.key,
      required this.buttonText,
      this.fontSize,
      this.onPressed,
      this.condition,
      this.shadows,
      this.gradient,
      this.color,
      this.textColor,
      this.border});

  final String buttonText;
  final double? fontSize;
  final void Function()? onPressed;
  final bool? condition;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;
  final Color? color;
  final Color? textColor;
  final BoxBorder? border;

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
        shadows: shadows,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: border,
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50.0)),
            depth: -4,
            intensity: 0.8,
            lightSource: LightSource.topLeft,
            color: const Color.fromRGBO(243, 243, 243, 1),
            shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 0.5),
            shadowLightColorEmboss: const Color.fromRGBO(255, 255, 255, 1),
          ),
          child: MaterialButton(
            onPressed: condition == true ? onPressed! : null,
            textColor: condition!
                ? textColor
                : const Color.fromRGBO(255, 255, 255, 0.2),
            disabledTextColor: const Color.fromRGBO(255, 255, 255, 0.1),
            disabledColor: const Color.fromRGBO(255, 255, 255, 0.1),
            splashColor: const Color.fromRGBO(243, 243, 243, 1),
            highlightColor: const Color.fromRGBO(243, 243, 243, 0.7),
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
                // border: border ?? null,
              ),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
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
        ),
      ),
    );
  }
}
