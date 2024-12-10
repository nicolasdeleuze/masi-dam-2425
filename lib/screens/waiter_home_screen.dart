import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/status.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/order_widget.dart';
import '../theme/styles/colored_button_style.dart';
import '../widgets/loader_widget.dart';

class WaiterHomeWidget extends StatefulWidget {
  final ComService comService;

  const WaiterHomeWidget({
    super.key,
    required this.comService,
  });

  @override
  State<WaiterHomeWidget> createState() => _WaiterHomeWidgetState();
}

class _WaiterHomeWidgetState extends State<WaiterHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: widget.comService.init("OpenAirPOS", UserRole.waiter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: <Widget>[
                          HeaderContainer(
                            height: 150,
                            width: width,
                            subtitle: 'Waiter',
                            userID : "RLE1234"
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "      List of orders",
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: LightColors.kDarkBlue,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 355,
                            child:
                            OrderListView(
                              // TODO : retreive order item from DB
                              orders: [
                                Order(orderNumber: 101),
                                Order(orderNumber: 102),
                                Order(orderNumber: 103),
                                Order(orderNumber: 104),
                                Order(orderNumber: 105),
                                Order(orderNumber: 106),
                                Order(orderNumber: 107),
                                Order(orderNumber: 108),
                              ],
                            )
                          ),
                        ],
                      ),
                      Positioned(
                        top: 120,
                        right: 30,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: access settings
                          },
                          style: coloredButtonStyle(
                            LightColors.kGreen,
                            LightColors.kLightYellow,
                          ),
                          icon: Icon(Icons.settings, size: 15,),
                          label: const Text(
                            'Settings',
                            style: coloredButtonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 0,
                      child:
                          ComServicePeersList(comService: widget.comService)),
                  NewOrderButton(width: width)
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

class NewOrderButton extends StatelessWidget {
  const NewOrderButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(
              color: LightColors.kLavender,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              )),
          height: 100,
          width: width,
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text(
                "Add a new order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: LightColors.kBlue,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,
          child: CircleAvatar(
            radius: 35,
            backgroundColor: LightColors.kLavender,
            child: ElevatedButton(
              onPressed: () {
                // TODO ajouter commande
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
    );
  }
}
