import 'package:flutter/material.dart';

import 'theme/colors/light_colors.dart';
import 'comm/com_service.dart';
import 'gui/roles.dart';

ComService comService = ComService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Air POS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: LightColors.kDarkBlue,
            displayColor: LightColors.kDarkBlue,
            fontFamily: 'Poppins'
        ),
      ),
      home: RolesWidget(comService: comService),
    );
  }
}


