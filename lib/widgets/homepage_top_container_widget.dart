import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/top_container_widget.dart';

class CustomTopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final String subtitle;
  final String avatarPath;

  const CustomTopContainer({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.subtitle,
    this.avatarPath = "assets/images/avatar.png",
  });

  @override
  Widget build(BuildContext context) {
    return TopContainer(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 30.0,
                backgroundColor: LightColors.kLightYellow,
                backgroundImage: AssetImage(avatarPath),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: LightColors.kDarkBlue,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
