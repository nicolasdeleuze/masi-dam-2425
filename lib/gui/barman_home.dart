import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

import 'theme.dart';

class BarmanHomeWidget extends StatelessWidget {
  BarmanHomeWidget(
      {super.key, required this.comService}
  );

  ComService comService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Barman'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            ElevatedButton(
              onPressed: () {

                // TODO
                // Start event
                // launch communication service as barman
                // Go to barman orders page

              },
              style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Start event',
                style: homeButtonTextStyle,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

                // TODO
                // Events manager
                // Go to events manager page

              },
              style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Events manager',
                style: homeButtonTextStyle,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

                // TODO
                // Inventory manager
                // Go to inventory manager page

              },
              style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Inventory',
                style: homeButtonTextStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}