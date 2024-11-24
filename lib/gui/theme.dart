import 'package:flutter/material.dart';
import '../theme/colors/light_colors.dart';

// home button style
final ButtonStyle homeButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(LightColors.kDarkYellow),
  foregroundColor: WidgetStateProperty.all<Color>(LightColors.kGreen),
  overlayColor: WidgetStateProperty.all<Color>(LightColors.kDarkYellow),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
  fixedSize: WidgetStateProperty.all<Size> (const Size(500, 150),),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

// home button text style
const TextStyle homeButtonTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

