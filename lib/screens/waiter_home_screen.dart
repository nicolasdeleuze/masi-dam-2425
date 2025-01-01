import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/screens/new_order_screen.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/order_widget.dart';
import 'package:masi_dam_2425/widgets/loader_widget.dart';
import 'package:provider/provider.dart';

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
/// Displays a list of orders and provides option to add new ones.
class _WaiterHomeWidgetState extends State<WaiterHomeWidget> {
  @override
  Widget build(BuildContext context) {
    final OrderViewModel viewModel =
        Provider.of<OrderViewModel>(context, listen: true);
    // TODO : retrieve only active orders
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
                    child: viewModel.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : viewModel.orders.isEmpty
                            ? const Center(child: Text("No orders added yet."))
                            : OrderListView(
                                orders: viewModel.orders,
                              ),
                  ),
                  SizedBox(
                    height: 0,
                    child: ComServicePeersList(comService: widget.comService),
                  ),
                  AddButton(
                    width: width,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewOrderScreen(),
                        ),
                      );
                    },
                    text: "Add a new order",
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
