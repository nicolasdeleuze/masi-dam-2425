import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';

import '../widgets/home_button_widget.dart';

class BarmanHomeWidget extends StatelessWidget {
  BarmanHomeWidget(
      {super.key, required this.comService}
  );

  ComService comService;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTopContainer(
                height: 150,
                width: width,
                subtitle: 'Bartender',
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}