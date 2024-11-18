import 'package:flutter/material.dart';

import 'comm/com_service.dart';
import 'gui/home.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeWidget(comService: comService),
    );
  }
}


