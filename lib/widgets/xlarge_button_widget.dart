import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';

class XLargeButton extends StatelessWidget {
  final String label;
  final UserRole role;
  final String iconPath;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;
  final Widget nextPage;
  final ComService comService;

  const XLargeButton({
    required this.label,
    required this.role,
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
    required this.nextPage,
    required this.comService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ),
          );
        },
        style: coloredButtonStyle(backgroundColor, textColor),
        child: Center(
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              buildButtonIcon(),
              SizedBox(width: 20.0),
              buildButtonLabel(),
            ],
          ),
        ),
      ),
    );
  }

  Text buildButtonLabel() {
    return Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
            );
  }

  ClipRRect buildButtonIcon() {
    return ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                iconPath,
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            );
  }
}
