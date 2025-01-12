import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/packet_manager.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/screens/waiter/order_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/widgets/com_service_peers_list_widget.dart';
import 'package:masi_dam_2425/widgets/containers/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/loader_widget.dart';
import 'package:provider/provider.dart';


class JoinNetworkScreen extends StatefulWidget {
  JoinNetworkScreen({super.key});

  ComService comService = ComService.getInstance();

  PacketManager packetManager = PacketManager.getInstance();

  Future<ConnectionState> initialize_p2p_client() async {
    packetManager.setUserID("RLE123");                                     // TODO : ! hardcoded
    ConnectionState cs = await comService.init("OpenAirPOS", Role.waiter);
    return cs;
  }

  @override
  State<JoinNetworkScreen> createState() => _JoinNetworkWidgetState();
}

class _JoinNetworkWidgetState extends State<JoinNetworkScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);

    dynamic readyStyle = coloredButtonStyle(LightColors.kBlue, LightColors.kLightYellow);
    dynamic notReadyStyle = coloredButtonStyle(LightColors.kLavender, LightColors.kLightYellow);

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: FutureBuilder(
                future: widget.initialize_p2p_client(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Consumer<ComService>(
                      builder: (context, comService, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            HeaderContainer(
                                width: width,
                                subtitle: 'Waiter',
                                userID: "RLE1234"
                            ),
                            Expanded(
                              child: ComServicePeersListWidget(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  print(
                                      "isReady: ${widget.comService.isConnected}");
                                  if (widget.comService.isConnected) {
                                    widget.comService.stopDiscoverPeers();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrderHomeWidget(),
                                      ),
                                    );
                                  }
                                },
                                style: widget.comService.isConnected
                                    ? readyStyle
                                    : notReadyStyle,
                                label: const Text(
                                  'Let\'s take some orders!',
                                  style: coloredButtonTextStyle,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    );
                  } else {
                    return LoaderWidget();
                  }
                }
            )
        ),
      ),
    );
  }
}