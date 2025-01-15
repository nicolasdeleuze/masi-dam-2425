import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/screens/admin/admin_home_screen.dart';
import 'package:masi_dam_2425/screens/waiter/join_network_screen.dart';
import 'package:masi_dam_2425/screens/waiter/order_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/screens/bartender/barman_home_screen.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/widgets/containers/header_container_widget.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/widgets/buttons/xlarge_button_widget.dart';

/// A widget that allows users to select a role (e.g., Bartender, Waiter, Admin)
/// and navigate to the corresponding home screen.
class RolesWidget extends StatefulWidget {
  RolesWidget({super.key});

  final ComService comService = ComService.getInstance();

  @override
  State<RolesWidget> createState() => _RolesWidgetState();
}

class _RolesWidgetState extends State<RolesWidget> {
  Role? role;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            HeaderContainer(
                width: width
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Select a role", style: extraBoldTitle(),),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(40.0),
                children: <Widget>[
                  XLargeButton(
                    label: 'Bartender',
                    role: Role.bartender,
                    iconPath: 'assets/images/bartender.png',
                    backgroundColor: LightColors.kGreen,
                    textColor: LightColors.kLightYellow,
                    nextPage: BarmanHomeWidget(),
                    comService: widget.comService,
                  ),
                  const SizedBox(height: 20),
                  XLargeButton(
                    label: 'Waiter',
                    role: Role.waiter,
                    iconPath: 'assets/images/waiter.png',
                    backgroundColor: LightColors.kRed,
                    textColor: LightColors.kLightYellow,
                    nextPage: JoinNetworkScreen(),
                    comService: widget.comService,
                  ),
                  const SizedBox(height: 20),
                  XLargeButton(
                    label: 'Admin',
                    role: Role.admin,
                    iconPath: 'assets/images/admin.png',
                    backgroundColor: LightColors.kBlue,
                    textColor: LightColors.kLightYellow,
                    nextPage: AdminHomeWidget(),
                    comService: widget.comService,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
