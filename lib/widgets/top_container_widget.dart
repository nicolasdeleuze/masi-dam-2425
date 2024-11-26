import 'package:flutter/material.dart';
import '../theme/colors/light_colors.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;

  const TopContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: padding,
      decoration: BoxDecoration(
        color: LightColors.kDarkYellow,
        borderRadius: const BorderRadius.all(Radius.circular(40.0))
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
