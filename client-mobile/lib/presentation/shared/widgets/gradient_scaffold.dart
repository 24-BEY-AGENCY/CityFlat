import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    super.key,
    required this.body,
    required this.gradient,
    this.appBar,
    this.extendBodyBehindAppBar,
  });

  final Widget body;
  final LinearGradient gradient;
  final PreferredSizeWidget? appBar;
  final bool? extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      appBar: appBar,
      body:
          Container(decoration: BoxDecoration(gradient: gradient), child: body),
    );
  }
}
