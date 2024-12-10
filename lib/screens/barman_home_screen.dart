import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';


class BarmanHomeWidget extends StatelessWidget {
  final ComService comService;

  const BarmanHomeWidget({
    super.key,
    required this.comService,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeaderContainer(
                height: 150,
                width: width,
                subtitle: 'Bartender',
                  userID : "RLE1234"
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}