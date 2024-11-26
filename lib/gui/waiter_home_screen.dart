import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';
import '../widgets/home_button_widget.dart';
import 'loader.dart';

class WaiterHomeWidget extends StatefulWidget {
  WaiterHomeWidget({super.key, required this.comService});

  ComService comService = ComService();

  @override
  State<WaiterHomeWidget> createState() => _WaiterHomeWidgetState();
}

class _WaiterHomeWidgetState extends State<WaiterHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.init('OpenAirPOS', UserRole.waiter);
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: widget.comService.init("OpenAirPOS", UserRole.waiter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomTopContainer(
                        height: 150,
                        width: width,
                        title: 'Welcome Rodrigues',
                        subtitle: 'Waiter',
                      ),
                      Spacer(),


                      // TODO
                      // List all available networks
                      // make it selecteable

                      Expanded(
                        child:  ComServicePeersList(comService: widget.comService),
                      ),



                      ElevatedButton(
                        onPressed: () {

                          // TODO
                          // Join selected network
                          // launch communication service as waiter
                          // Go to waiter orders page

                        },
                        style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
                        child: const Text(
                          'Join network',
                          style: homeButtonTextStyle,
                        ),
                      ),
                      Spacer()
                    ],
                  );
                } else {
                  return Loader();
                }
              }
          )
      ),
    );
  }
}