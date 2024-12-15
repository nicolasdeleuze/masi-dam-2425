import 'package:flutter/material.dart';
import 'package:masi_dam_2425/gui/admin_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/gui/barman_home_screen.dart';
import 'package:masi_dam_2425/gui/waiter_home_screen.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';
import 'package:masi_dam_2425/widgets/top_container_widget.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/role_button_widget.dart';

class RolesWidget extends StatefulWidget {
  RolesWidget({super.key});

  ComService? comService;

  @override
  State<RolesWidget> createState() => _RolesWidgetState();
}

class _RolesWidgetState extends State<RolesWidget> {
  UserRole? role;

  @override
  Widget build(BuildContext context) {
    widget.comService = ComService.getInstance();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTopContainer(
              height: 150,
              width: width,
              title: 'Welcome Rodrigues',
              subtitle: 'Select your role',
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(40.0),
                children: <Widget>[
                  RoleButton(
                    label: 'Bartender',
                    role: UserRole.barman,
                    iconPath: 'assets/images/bartender.png',
                    iconColor : LightColors.kLightYellow,
                    backgroundColor: LightColors.kGreen,
                    textColor: LightColors.kLightYellow,
                    nextPage: BarmanHomeWidget(),
                  ),
                  const SizedBox(height: 20),
                  RoleButton(
                    label: 'Waiter',
                    role: UserRole.waiter,
                    iconPath: 'assets/images/waiter.png',
                    iconColor : LightColors.kLightYellow,
                    backgroundColor: LightColors.kRed,
                    textColor: LightColors.kLightYellow,
                    nextPage: WaiterHomeWidget(),
                    beforeNextPage: () async {
                      await widget.comService!.init("OpenAirPOS", UserRole.waiter);
                    },
                  ),
                  const SizedBox(height: 20),
                  RoleButton(
                    label: 'Admin',
                    role: UserRole.admin,
                    iconPath: 'assets/images/admin.png',
                    iconColor : LightColors.kLightYellow,
                    backgroundColor: LightColors.kBlue,
                    textColor: LightColors.kLightYellow,
                    nextPage: AdminHomeWidget(),
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
