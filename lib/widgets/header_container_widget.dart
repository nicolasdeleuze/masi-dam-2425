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
    this.height = 110.0,
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
          top: 70,
          left:110,
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
        radius: 35.0,
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

  IconButton buildSettingsButton() {
    return IconButton(
      onPressed: () {
        // TODO: access settings
      },
      icon: const Icon(
        Icons.settings,
        size: 30,
        color: LightColors.kLightYellow,
      ),
      splashRadius: 24.0,
      tooltip: 'Settings',
    );
  }
}