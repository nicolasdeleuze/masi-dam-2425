
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

InputDecoration underlinedTextfieldStyle (String label, Icon? icon){
  return InputDecoration(
    labelText: label,
    prefixIcon: icon,
    labelStyle: TextStyle(color: LightColors.kDarkBlue),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: LightColors.kDarkBlue, width: 0.0),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: LightColors.kDarkBlue, width: 1.5),
    ),
    floatingLabelStyle: TextStyle(color: LightColors.kDarkBlue),
  );
}

InputDecoration cleanTextfieldStyle (String label, Icon? icon){
  return InputDecoration(
    labelText: label,
    prefixIcon: icon,
    labelStyle: TextStyle(color: LightColors.kDarkBlue),
    floatingLabelStyle: TextStyle(color: LightColors.kDarkBlue),
    border: InputBorder.none,
  );
}
