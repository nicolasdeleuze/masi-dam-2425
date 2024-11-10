import 'package:flutter/material.dart';

// home button style
final ButtonStyle homeButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all<Color>(Colors.deepPurple),
  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
  overlayColor: WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
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

