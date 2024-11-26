import 'package:flutter/material.dart';

// home button style
ButtonStyle homeButtonStyle(Color backgroundColor, Color foregroundColor) {
  return ButtonStyle(
    backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
    foregroundColor: WidgetStateProperty.all<Color>(foregroundColor),
    overlayColor: WidgetStateProperty.all<Color>(backgroundColor),
    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}

// home button text style
const TextStyle homeButtonTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

