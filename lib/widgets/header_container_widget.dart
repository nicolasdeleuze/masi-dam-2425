import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/colored_container_widget.dart';

class HeaderContainer extends StatelessWidget {
  final double height;
  final double width;
  final String subtitle;
  final String avatarPath;
  final String userName = "Rodrigues";
  final String userID;

  const HeaderContainer({
    super.key,
    this.height = 150.0,
    required this.width,
    required this.subtitle,
    this.avatarPath = "assets/images/avatarMale.png",
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildHeaderContainer(),
        Positioned(
          top: 120,
          right: 30,
          child: buildSettingsButton(),
        ),
      ],
    );
  }

  ColoredContainer buildHeaderContainer() {
    return ColoredContainer(
        color: LightColors.kDarkYellow,
        height: height,
        width: width,
        radius: 40.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildAvatar(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildWelcomeTitle(),
                    buildSectionSubtitle(),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }

  Text buildSectionSubtitle() {
    return Text(
                    "$subtitle $userID",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                    ),
                  );
  }

  Text buildWelcomeTitle() {
    return Text(
                    "Hello, $userName",
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: LightColors.kDarkBlue,
                      fontWeight: FontWeight.w800,
                    ),
                  );
  }

  ClipRRect buildAvatar() {
    return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  avatarPath,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.cover,
                ),
              );
  }

  ElevatedButton buildSettingsButton() {
    return ElevatedButton.icon(
          onPressed: () {
            // TODO: access settings
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: LightColors.kGreen,
            foregroundColor: LightColors.kLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          ),
          icon: const Icon(
            Icons.settings,
            size: 15,
          ),
          label: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
  }
}