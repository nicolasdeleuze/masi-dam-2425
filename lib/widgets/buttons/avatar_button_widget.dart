import 'package:flutter/material.dart';

class AvatarButtonWidget extends StatelessWidget {
  final String avatarPath;
  final GestureTapCallback onTap;
  final double size;

  const AvatarButtonWidget({
    super.key,
    required this.avatarPath,
    required this.onTap,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            avatarPath,
            height: size,
            width: size,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
