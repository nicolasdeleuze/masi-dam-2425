import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/home_button_widget.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';
import 'package:masi_dam_2425/widgets/top_container_widget.dart';

class AdminHomeWidget extends StatelessWidget {
  const AdminHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTopContainer(
              height: 150,
              width: width,
              subtitle: 'Event Administrator',
            ),
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
