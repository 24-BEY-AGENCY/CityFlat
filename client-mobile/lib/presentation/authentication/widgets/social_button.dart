import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

class SocialButton extends StatefulWidget {
  final String? svgString;
  final double? height;

  const SocialButton({
    Key? key,
    this.svgString,
    this.height,
  }) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: const Color.fromRGBO(60, 59, 59, 1),
          width: 0.5,
        ),
      ),
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50.0)),
          depth: isPressed ? 7 : -7,
          intensity: 0.8,
          lightSource: LightSource.topLeft,
          color: const Color.fromRGBO(37, 40, 46, 1),
          shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 1),
          shadowDarkColor: const Color.fromRGBO(0, 0, 0, 1),
          shadowLightColor: const Color.fromRGBO(37, 40, 46, 1),
          shadowLightColorEmboss: const Color.fromRGBO(37, 40, 46, 1),
        ),
        child: Neumorphic(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50.0)),
            depth: isPressed ? 7 : -5,
            intensity: 0.7,
            surfaceIntensity: 1.0,
            lightSource: LightSource.topLeft,
            color: const Color.fromRGBO(37, 40, 46, 1),
            shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 1),
            shadowDarkColor: const Color.fromRGBO(0, 0, 0, 1),
            shadowLightColor: const Color.fromRGBO(37, 40, 46, 1),
            shadowLightColorEmboss: const Color.fromRGBO(37, 40, 46, 1),
          ),
          child: IconButton(
            icon: SvgPicture.asset(
              widget.svgString!,
              fit: BoxFit.fitHeight,
              height: widget.height,
            ),
            onPressed: () {
              setState(() {
                isPressed = !isPressed;
              });

              Future.delayed(const Duration(milliseconds: 150), () {
                setState(() {
                  isPressed = !isPressed;
                });
              });
            },
          ),
        ),
      ),
    );
  }
}
