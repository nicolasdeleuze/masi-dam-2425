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

/// A widget representing the Waiter's home screen.
/// Displays a list of orders and provides options to add new ones.
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
                  HeaderContainer(
                    height: 150,
                    width: width,
                    subtitle: 'Waiter',
                    userID: "RLE1234",
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
                  Expanded(
                    child: OrderListView(
                      // TODO : retrieve order item from DB
                      orders: [
                        Order(id: 101),
                        Order(id: 102),
                        Order(id: 103),
                        Order(id: 104),
                        Order(id: 105),
                        Order(id: 106),
                        Order(id: 107),
                        Order(id: 108),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                    child: ComServicePeersList(comService: widget.comService),
                  ),
                  NewOrderButton(width: width),
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


/// A button to add a new order, displayed at the bottom of the screen.
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
