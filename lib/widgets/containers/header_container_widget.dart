import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/view_model/staff_view_model.dart';
import 'package:masi_dam_2425/widgets/containers/colored_container_widget.dart';
import 'package:provider/provider.dart';

/// This widget is designed to be displayed at the top of the screen.
/// It shows a profile picture, the name of the current user, and their ID.
/// Additionally, it includes menu buttons for easy access to critical features.
class HeaderContainer extends StatelessWidget {
  final double height;
  final double width;
  final String avatarPath;

  const HeaderContainer({
    super.key,
    this.height = 110.0,
    required this.width,
    this.avatarPath = "assets/images/avatarMale.png",
  });

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final String username = userViewModel.user!.firstname;
    final String userID = userViewModel.user!.id;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        buildHeaderContainer(username,userID),
        Positioned(
          top: 8,
          left: 12,
          child: buildSettingsButton(),
        ),
      ],
    );
  }

  ColoredContainer buildHeaderContainer(username, userID) {
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
                  buildWelcomeTitle(username),
                  buildSectionSubtitle(userID),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text buildSectionSubtitle(String userID) {
    return Text(
      userID,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black45,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text buildWelcomeTitle(String username) {
    return Text(
      "Hello, $username",
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
        Icons.settings_sharp,
        size: 30,
        color: Colors.black54,
      ),
      splashRadius: 24.0,
      tooltip: 'Settings',
    );
  }
}
