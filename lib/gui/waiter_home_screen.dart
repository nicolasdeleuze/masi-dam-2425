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
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: FutureBuilder(
          future: widget.comService.init("OpenAirPOS", UserRole.waiter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  CustomTopContainer(
                    height: 150,
                    width: width,
                    subtitle: 'Waiter',
                  ),
                  Expanded(
                    child: ComServicePeersList(
                      comService: widget.comService,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // TODO: rejoindre un réseau
                            print("join network");
                          },
                          style: homeButtonStyle(
                            LightColors.kGreen,
                            LightColors.kLightYellow,
                          ),
                          child: const Text(
                            'Join network',
                            style: homeButtonTextStyle,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: LightColors.kLavender,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                    )),
                                height: 100,
                                width: width,
                                alignment: Alignment.center,
                                child: const Text(
                                  "Add a new order",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: LightColors.kBlue,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -30,
                                left: width / 2 - 35,
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: LightColors.kLavender,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO ajouter commande
                                      print("new order");
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(15),
                                      backgroundColor: LightColors.kBlue,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 30,
                                      color: LightColors.kLightYellow,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Loader();
            }
          },
        ),
      ),
    );
  }
}
