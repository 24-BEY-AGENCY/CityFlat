import 'package:cityflat/presentation/shared/widgets/custom_title.dart';
import 'package:flutter/material.dart';

import 'custom_back_button.dart';

class CustomAppbarNoImage extends StatefulWidget {
  final String? title;
  final Function()? onPressed;

  const CustomAppbarNoImage({super.key, this.title, this.onPressed});

  @override
  State<CustomAppbarNoImage> createState() => _CustomAppbarNoImageState();
}

class _CustomAppbarNoImageState extends State<CustomAppbarNoImage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: CustomBackButton(onPressed: widget.onPressed!)),
        CustomTitle(
          title: widget.title!,
          fontSize: 26.0,
        ),
      ],
    );
  }
}
