import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
}) {
  return TextField(
    controller: controller,
    onChanged: (value) {
      controller.text = value;
    },
    cursorColor: LightColors.kDarkBlue,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600]),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: LightColors.kDarkBlue, width: 2.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIcon: Icon(icon),
    ),
  );
}