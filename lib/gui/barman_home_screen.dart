import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/gui/loader.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';

import '../widgets/home_button_widget.dart';

class BarmanHomeWidget extends StatefulWidget {
  BarmanHomeWidget(
      {super.key}
  );

  ComService comService = ComService.getInstance();

  @override
  State<BarmanHomeWidget> createState() => _BarmanHomeWidgetState();
}

class _BarmanHomeWidgetState extends State<BarmanHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: widget.comService.init("OpenAirPOS", UserRole.barman),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomTopContainer(
                  height: 150,
                  width: width,
                  title: 'Welcome Rodrigues',
                  subtitle: 'Bartender',
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // TODO
                    // Enable p2p newtwork
                    // launch communication service as bartender
                    // Go to bartender orders page

                    // Execute the following code block as a single async function
                    // to keep order execution
                    () async {
                      widget.comService.start();
                      widget.comService.startSocket();
                    }();

                  },
                  style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
                  child: Text('Enable Network'),
                ),
                Spacer(),
              ],
            );
          } else {
            return Loader();
          }
        },
      ),
    );
  }
}