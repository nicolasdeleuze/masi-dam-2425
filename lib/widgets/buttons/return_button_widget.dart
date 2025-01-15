import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

/// This widget represents a button that is intended to be displayed at
/// the bottom of the screen.
/// It requires an icon, a label (prompt), and a function that defines
/// the action to perform when the button is pressed.
class ReturnButton extends StatelessWidget {
  const ReturnButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.label,
  });

  final double width;
  final Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        backgroundColor: LightColors.kBlue,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: LightColors.kLightYellow,
            ),
          ),
        ],
      ),
    );
  }
}