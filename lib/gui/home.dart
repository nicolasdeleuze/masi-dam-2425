import 'package:flutter/material.dart';

import 'theme.dart';

import 'barman_home.dart';
import 'waiter_home.dart';

import '../comm/com_service.dart';
import '../comm/user_role.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({super.key});

  UserRole? role;
  ComService comService = ComService();

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Choose your role'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            ElevatedButton(
                onPressed: () {
                  widget.role = UserRole.barman;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BarmanHomeWidget())
                  );
                },
                style: homeButtonStyle,
                child: const Text(
                    'Barman',
                  style: homeButtonTextStyle,
                ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  widget.role = UserRole.waiter;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WaiterHomeWidget())
                  );
                },
                style: homeButtonStyle,
                child: const Text(
                    'Waiter',
                  style: homeButtonTextStyle,
                ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}