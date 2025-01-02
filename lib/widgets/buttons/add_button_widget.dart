import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

/// This widget represents a button that is intended to be displayed at
/// the bottom of the screen.
/// It requires an icon, a label (prompt), and a function that defines
/// the action to perform when the button is pressed.
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final double width;
  final Function()? onPressed;
  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              color: LightColors.kLightGreen,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              )),
          height: 100,
          width: width,
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: LightColors.kGreen,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,
          child: CircleAvatar(
            radius: 35,
            backgroundColor: LightColors.kLightGreen,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15),
                backgroundColor: LightColors.kGreen,
              ),
              child: Icon(
                icon,
                size: 30,
                color: LightColors.kLightYellow,
              ),
            ),
          ),
        ),
      ],
    );
  }
}