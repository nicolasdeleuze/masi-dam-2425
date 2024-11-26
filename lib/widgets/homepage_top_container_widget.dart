import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/top_container_widget.dart';

class CustomTopContainer extends StatelessWidget {
  final double height;
  final double width;
  final String subtitle;
  final String avatarPath;
  final _name = "Rodrigues";

  const CustomTopContainer({
    super.key,
    required this.height,
    required this.width,
    required this.subtitle,
    this.avatarPath = "assets/images/avatarMale.png",
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
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  avatarPath,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello, $_name",
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
