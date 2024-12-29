import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';
import '../comm/user_role.dart';
import '../widgets/home_button_widget.dart';
import 'loader.dart';

class WaiterHomeWidget extends StatefulWidget {
  WaiterHomeWidget({super.key});

  ComService comService = ComService.getInstance();

  Future<ConnectionState> initialize_p2p_client() async {
      ConnectionState cs = await comService.init("OpenAirPOS", UserRole.waiter);
      return cs;
  }

  @override
  State<WaiterHomeWidget> createState() => _WaiterHomeWidgetState();
}

class _WaiterHomeWidgetState extends State<WaiterHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);

    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: widget.initialize_p2p_client(),
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
                      Expanded(
                        child:  ComServicePeersList(),
                      ),
                      Spacer(),


                      // TODO
                      // to remove, just for testing
                      ElevatedButton(
                        onPressed: () {
                          widget.comService.sendString("Hello from waiter");
                        },
                        style: homeButtonStyle(LightColors.kLightGreen, LightColors.kDarkBlue),
                        child: const Text(
                          'Send message',
                          style: homeButtonTextStyle,
                        ),
                      ),
                      Spacer(),
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