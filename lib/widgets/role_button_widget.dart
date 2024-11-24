import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/home_button_widget.dart';

class RoleButton extends StatelessWidget {
  final String label;
  final UserRole role;
  final Color backgroundColor;
  final Color textColor;
  final Widget nextPage;
  final ComService comService;

  const RoleButton({
    required this.label,
    required this.role,
    required this.backgroundColor,
    required this.textColor,
    required this.nextPage,
    required this.comService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ),
          );
        },
        style: homeButtonStyle(backgroundColor, textColor),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: const AssetImage("assets/images/avatar.png"),
            ),
            Text(
              label,
              style: homeButtonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}