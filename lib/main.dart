import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/repository/dataservice.dart';
import 'package:masi_dam_2425/screens/authentication_screen.dart';
import 'package:masi_dam_2425/view_model/menu_view_model.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';
import 'package:masi_dam_2425/view_model/staff_view_model.dart';
import 'package:provider/provider.dart';
import 'theme/colors/light_colors.dart';
import 'screens/roles_selection_screen.dart';

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
        ChangeNotifierProvider(
          create: (context) => ProductViewModel(dataService.productRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => MenuViewModel(dataService.menuRepository, dataService.productRepository),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ComService.getInstance()
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
      home: AuthenticationScreen(),
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


