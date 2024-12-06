import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/order_item_widget.dart';
import '../theme/styles/colored_button_style.dart';
import '../widgets/loader_widget.dart';

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
      body: SafeArea(
        child: FutureBuilder(
          future: widget.comService.init("OpenAirPOS", UserRole.waiter),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget> [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        children: <Widget> [
                          HeaderContainer(
                            height: 150,
                            width: width,
                            subtitle: 'Waiter',
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 290,
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              children: [
                                OrderItemWidget(
                                  orderNumber: 1,
                                  status: "Command send",
                                  price: 10,
                                ),
                                OrderItemWidget(
                                  orderNumber: 2,
                                  status: "Delivered",
                                  price: 10,
                                ),
                                OrderItemWidget(
                                  orderNumber: 3,
                                  status: "Delivered",
                                  price: 10,
                                ),
                                OrderItemWidget(
                                  orderNumber: 4,
                                  status: "To deliver",
                                  price: 10,
                                ),
                                OrderItemWidget(
                                  orderNumber: 5,
                                  status: "To deliver",
                                  price: 10,
                                ),
                                OrderItemWidget(
                                  orderNumber: 700,
                                  status: "Command send",
                                  price: 10,
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 105,
                        right: 50,
                        child: ElevatedButton(
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
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 0,
                      child:
                          ComServicePeersList(comService: widget.comService)),
                  newOrderButton(width: width)
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

class newOrderButton extends StatelessWidget {
  const newOrderButton({
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
    );
  }
}
