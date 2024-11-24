import 'package:flutter/material.dart';
import 'package:masi_dam_2425/gui/admin_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/gui/barman_home_screen.dart';
import 'package:masi_dam_2425/gui/waiter_home_screen.dart';
import 'package:masi_dam_2425/widgets/top_container_widget.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/role_button_widget.dart';

class RolesWidget extends StatefulWidget {
  RolesWidget({super.key, required ComService this.comService});

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kLightGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  UserRole? role;
  ComService? comService;

  @override
  State<RolesWidget> createState() => _RolesWidgetState();
}

class _RolesWidgetState extends State<RolesWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TopContainer(
              height: 150,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(Icons.menu,
                          color: LightColors.kDarkBlue, size: 30.0),
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          "assets/images/avatar.png",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Welcome Rodrigues',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: LightColors.kDarkBlue,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Choose your role',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black45,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    RoleButton(
                      label: 'Barman',
                      role: UserRole.barman,
                      backgroundColor: LightColors.kGreen,
                      textColor: LightColors.kLightYellow,
                      nextPage: BarmanHomeWidget(comService: widget.comService!),
                      comService: widget.comService!,
                    ),
                    const Spacer(),
                    RoleButton(
                      label: 'Waiter',
                      role: UserRole.waiter,
                      backgroundColor: LightColors.kRed,
                      textColor: LightColors.kLightYellow,
                      nextPage: WaiterHomeWidget(comService: widget.comService!),
                      comService: widget.comService!,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                RoleButton(
                  label: 'Admin',
                  role: UserRole.admin,
                  backgroundColor: LightColors.kBlue,
                  textColor: LightColors.kLightYellow,
                  nextPage: AdminHomeWidget(),
                  comService: widget.comService!,
                ),
              ],
            ),
            const Spacer(),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

