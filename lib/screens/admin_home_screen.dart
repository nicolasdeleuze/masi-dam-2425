import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';

/// A widget representing the Administrator's home screen.
/// Provides tools for managing events, supervising past events, and user management.
class AdminHomeWidget extends StatelessWidget {
  const AdminHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HeaderContainer(
              width: width,
              subtitle: 'Event Admin',
                userID : "RLE1234"
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

                // TODO
                // Start event
                // launch communication service as barman
                // Go to barman orders page

              },
              style: coloredButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Start event',
                style: coloredButtonTextStyle,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {

                // TODO
                // Events manager
                // Go to events manager page

              },
              style: coloredButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Events manager',
                style: coloredButtonTextStyle,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO
                // Inventory manager
                // Go to inventory manager page
              },
              style: coloredButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
              child: const Text(
                'Inventory',
                style: coloredButtonTextStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
