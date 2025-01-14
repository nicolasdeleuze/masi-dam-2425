import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';

/// This widget represents a button that is intended to be displayed at
/// the bottom of the screen.
/// It requires an icon, a label (prompt), and a function that defines
/// the action to perform when the button is pressed.
class PeerButton extends StatelessWidget {
  const PeerButton({
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
        backgroundColor: LightColors.kLavender,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.rotate(
            angle: 45 * 3.141592653589793 / 180,
            child: Icon(
              Icons.wifi_rounded,
              size: 30,
              color: LightColors.kBlue,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: LightColors.kDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}