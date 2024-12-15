import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/home_button_widget.dart';

class RoleButton extends StatelessWidget {
  final String label;
  final UserRole role;
  final String iconPath;
  final Color iconColor;
  final Color backgroundColor;
  final Color textColor;
  final Widget nextPage;
  Function? beforeNextPage;
  ComService comService = ComService.getInstance();

  RoleButton({
    required this.label,
    required this.role,
    required this.iconPath,
    required this.iconColor,
    required this.backgroundColor,
    required this.textColor,
    required this.nextPage,
    this.beforeNextPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ElevatedButton(
        onPressed: () {
          if(beforeNextPage != null) {
            beforeNextPage!();
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ),
          );
        },
        style: homeButtonStyle(backgroundColor, textColor),
        child: Center(
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  iconPath,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20.0),
              Text(
                label,
                style: homeButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
