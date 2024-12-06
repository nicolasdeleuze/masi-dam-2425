import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsets padding;

  const ColoredContainer({
    super.key,
    required this.height,
    required this.width,
    required this.child,
    required this.color,
    this.radius = 25.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 0.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8,top: 8),
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(radius))
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
