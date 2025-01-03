
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
        strokeAlign: 15,
      ),
    );
  }
}