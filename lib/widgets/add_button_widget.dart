import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

/// A button to add a new order, displayed at the bottom of the screen.
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.text,
  });

  final double width;
  final Function()? onPressed;
  final String text;

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
                text,
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
              child: const Icon(
                Icons.add,
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