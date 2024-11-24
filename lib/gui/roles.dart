import 'package:flutter/material.dart';
import 'package:masi_dam_2425/gui/theme.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/gui/barman_home.dart';
import 'package:masi_dam_2425/gui/waiter_home.dart';
import 'package:masi_dam_2425/widgets/top_container.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';

class RolesWidget extends StatefulWidget {
  RolesWidget({super.key, required ComService this.comService});

  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
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
                        backgroundColor: LightColors.kGreen,
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          "assets/images/avatar.png",
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Rodrigues Lejeune',
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
            Row(
              children: [
                const Spacer(),
                SizedBox(
                    height: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.role = UserRole.barman;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarmanHomeWidget(
                                    comService: widget.comService!)));
                      },
                      style: homeButtonStyle,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: LightColors.kGreen,
                            radius: 50.0,
                            backgroundImage: AssetImage(
                              "assets/images/avatar.png",
                            ),
                          ),

                          const Text(
                            'Barman',
                            style: homeButtonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                const Spacer(),
                  SizedBox(
                    height: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.role = UserRole.waiter;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WaiterHomeWidget(
                                    comService: widget.comService!)));
                      },
                      style: homeButtonStyle,
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: LightColors.kGreen,
                            radius: 50.0,
                            backgroundImage: AssetImage(
                              "assets/images/avatar.png",
                            ),
                          ),
                          const Text(
                            'Waiter',
                            style: homeButtonTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),

                const Spacer(),
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
