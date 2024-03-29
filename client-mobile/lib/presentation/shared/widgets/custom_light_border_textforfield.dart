import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomLightBorderTextformfield extends StatelessWidget {
  const CustomLightBorderTextformfield(
      {Key? key,
      this.initialValue,
      this.enabled,
      this.customValidator,
      this.customTextInputAction,
      this.customKeyboardType,
      this.inputFormatters,
      this.textCapitalization,
      this.onSaved,
      this.customKey,
      this.customFocusNode,
      this.customHintText,
      this.onChanged,
      this.isValid,
      this.prefixIcon,
      this.prefix,
      this.suffixIcon,
      this.readOnly,
      this.onTap,
      this.customController,
      this.obscureText,
      this.maxLines,
      this.contentPadding,
      this.isError,
      this.intensity,
      this.noFocus})
      : super(key: key);

  final String? initialValue;
  final bool? enabled;
  final String? Function(String?)? customValidator;
  final TextInputAction? customTextInputAction;
  final TextInputType? customKeyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final Function(String?)? onSaved;
  final GlobalKey<FormFieldState>? customKey;
  final FocusNode? customFocusNode;
  final String? customHintText;
  final void Function(String?)? onChanged;
  final bool? isValid;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool? readOnly;
  final void Function()? onTap;
  final TextEditingController? customController;
  final bool? obscureText;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isError;
  final double? intensity;
  final bool? noFocus;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    return Neumorphic(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50.0)),
        depth: -4,
        intensity: intensity ?? 0.6,
        lightSource: LightSource.topLeft,
        color: const Color.fromRGBO(247, 247, 247, 1),
        shadowDarkColorEmboss: const Color.fromRGBO(0, 0, 0, 0.5),
        shadowLightColorEmboss: const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: TextFormField(
        key: customKey,
        initialValue: initialValue,
        enabled: enabled,
        readOnly: readOnly ?? false,
        onTap: onTap,
        validator: customValidator,
        keyboardType: customKeyboardType,
        inputFormatters: inputFormatters ?? [],
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        textInputAction: customTextInputAction!,
        onSaved: onSaved,
        controller: customController,
        obscureText: obscureText ?? false,
        cursorColor: const Color.fromRGBO(6, 190, 86, 1),
        style: TextStyle(
          color: const Color.fromRGBO(26, 26, 26, 1),
          fontSize: 18.0 * curScaleFactor,
          fontFamily: 'TT Commons',
          fontWeight: FontWeight.w500,
        ),
        focusNode: customFocusNode,
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 0.04),
          focusedBorder: noFocus != null && noFocus!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.04)),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(
                    color: isError != null && isError!
                        ? const Color.fromRGBO(190, 6, 6, 0.6)
                        : const Color.fromRGBO(6, 190, 86, 1),
                    width: 1.0,
                  ),
                ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: isError != null && isError!
                  ? const Color.fromRGBO(190, 6, 6, 0.6)
                  : const Color.fromRGBO(222, 222, 222, 1),
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          hintText: customHintText,
          hintStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16.0 * curScaleFactor,
            fontWeight: FontWeight.w300,
            color: const Color.fromRGBO(188, 188, 188, 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Color.fromRGBO(190, 6, 6, 0.6),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: const BorderSide(
              width: 1.0,
              color: Color.fromRGBO(190, 6, 6, 1),
            ),
          ),
          errorStyle: const TextStyle(
              color: Colors.transparent, fontSize: 0, height: -1.0),
          prefixIcon: prefixIcon != null
              ? Container(
                  margin: const EdgeInsets.only(left: 25.0, right: 20.0),
                  child: prefixIcon,
                )
              : null,
          prefix: prefix,
          suffixIcon: suffixIcon,
          errorText: null,
        ),
      ),
    );
  }
}
