import 'package:flutter/material.dart';
import '../theme/colors/light_colors.dart';

// home button style
ButtonStyle homeButtonStyle(Color backgroundColor, Color foregroundColor) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
    foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
    overlayColor: WidgetStateProperty.all<Color>(backgroundColor),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

// home button text style
const TextStyle homeButtonTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

