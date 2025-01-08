import 'package:flutter/material.dart';
import 'package:masi_dam_2425/gui/barman_order_list_screen.dart';
import 'package:provider/provider.dart';

import 'comm/com_service.dart';
import 'theme/colors/light_colors.dart';
import 'gui/roles_selection_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ComService.getInstance(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ComService comService = ComService.getInstance();
    comService.setContext(context);

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
      home: BarmanOrderListScreen(),
    );
  }
}


