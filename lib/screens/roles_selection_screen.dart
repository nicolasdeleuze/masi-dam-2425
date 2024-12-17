import 'package:flutter/material.dart';
import 'package:masi_dam_2425/screens/admin_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/screens/barman_home_screen.dart';
import 'package:masi_dam_2425/screens/waiter_home_screen.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/xlarge_button_widget.dart';

/// A widget that allows users to select a role (e.g., Bartender, Waiter, Admin)
/// and navigate to the corresponding home screen.
class RolesWidget extends StatefulWidget {
  const RolesWidget({super.key, required ComService this.comService});

  final ComService? comService;

  @override
  State<RolesWidget> createState() => _RolesWidgetState();
}

class _RolesWidgetState extends State<RolesWidget> {
  UserRole? role;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
              HeaderContainer(
                  width: width, subtitle: 'Select a role', userID: "RLE1234"),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(40.0),
                children: <Widget>[
                  XLargeButton(
                    label: 'Bartender',
                    role: UserRole.barman,
                    iconPath: 'assets/images/bartender.png',
                    iconColor: LightColors.kLightYellow,
                    backgroundColor: LightColors.kGreen,
                    textColor: LightColors.kLightYellow,
                    nextPage: BarmanHomeWidget(comService: widget.comService!),
                    comService: widget.comService!,
                  ),
                  const SizedBox(height: 20),
                  XLargeButton(
                    label: 'Waiter',
                    role: UserRole.waiter,
                    iconPath: 'assets/images/waiter.png',
                    iconColor: LightColors.kLightYellow,
                    backgroundColor: LightColors.kRed,
                    textColor: LightColors.kLightYellow,
                    nextPage: WaiterHomeWidget(comService: widget.comService!),
                    comService: widget.comService!,
                  ),
                  const SizedBox(height: 20),
                  XLargeButton(
                    label: 'Admin',
                    role: UserRole.admin,
                    iconPath: 'assets/images/admin.png',
                    iconColor: LightColors.kLightYellow,
                    backgroundColor: LightColors.kBlue,
                    textColor: LightColors.kLightYellow,
                    nextPage: AdminHomeWidget(),
                    comService: widget.comService!,
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
