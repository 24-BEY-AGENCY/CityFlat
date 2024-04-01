import 'package:flutter/material.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({
    super.key,
    this.min,
    this.max,
    this.currentRangeValues,
    this.onChanged,
  });

  final double? min;
  final double? max;
  final RangeValues? currentRangeValues;
  final void Function(RangeValues)? onChanged;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  RangeValues currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaler.scale(1);

    buildLabel(double value) {
      return Text(
        "${value.round().toString()} €",
        style: TextStyle(
          color: const Color.fromRGBO(26, 27, 26, 1),
          fontSize: 21 * curScaleFactor,
          fontWeight: FontWeight.w700,
          fontFamily: 'TT Commons',
          letterSpacing: 2,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
              child: Row(
                children: [
                  buildLabel(
                    widget.currentRangeValues!.start,
                  ),
                  const Spacer(),
                  buildLabel(widget.currentRangeValues!.end),
                ],
              )),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: RangeSlider(
              values: widget.currentRangeValues!,
              min: widget.min!,
              max: widget.max!,
              onChanged: widget.onChanged,
              activeColor: const Color.fromRGBO(2, 129, 57, 1),
              inactiveColor: const Color.fromRGBO(105, 119, 111, 0.1),
            ),
          ),
        ],
      ),
    );
  }
}
