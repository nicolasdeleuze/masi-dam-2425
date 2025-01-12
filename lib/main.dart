import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_manager.dart';
import 'package:masi_dam_2425/repository/dataservice.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';
import 'package:provider/provider.dart';
import 'theme/colors/light_colors.dart';
import 'screens/roles_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = DataService();
  await dataService.initialize();
  final ComService comService = ComService.getInstance();
  final PacketManager messageManager = PacketManager.getInstance(comService: comService);
  comService.setMessageManager(messageManager);
  messageManager.start();

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
          create: (context) => ComService.getInstance()
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      PacketManager.getInstance().stop();
      Provider.of<ComService>(context, listen: false).closeSocket();
      Provider.of<ComService>(context, listen: false).stop();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Air POS',
      theme: _buildThemeData(context),
      home: RolesWidget(),
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


