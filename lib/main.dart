import 'package:flutter/material.dart';
import 'package:masi_dam_2425/repository/dataservice.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:provider/provider.dart';
import 'theme/colors/light_colors.dart';
import 'comm/com_service.dart';
import 'screens/roles_selection_screen.dart';

ComService comService = ComService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = DataService();
  await dataService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderViewModel(dataService.orderRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Air POS',
      theme: _buildThemeData(context),
      home: RolesWidget(comService: comService),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    const darkBlue = LightColors.kDarkBlue;
    const lightYellow = LightColors.kLightYellow;

    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: darkBlue,
          fontFamily: 'Poppins',
        ),
        displayLarge: TextStyle(
          color: darkBlue,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      scaffoldBackgroundColor: lightYellow,
    );
  }
}
