import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';

class XLargeButton extends StatelessWidget {
  final String label;
  final Role role;
  final String iconPath;
  final Color backgroundColor;
  final Color textColor;
  final Widget nextPage;
  final ComService comService;

  const XLargeButton({
    required this.label,
    required this.role,
    required this.iconPath,
    required this.backgroundColor,
    required this.textColor,
    required this.nextPage,
    required this.comService,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
      style: coloredButtonStyle(backgroundColor, textColor),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: buildButtonIcon(),
          ),
          buildButtonLabel(),
        ],
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
      child: Image.asset(
        iconPath,
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
