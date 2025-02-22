import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/widgets/containers/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/loader_widget.dart';
import 'package:masi_dam_2425/widgets/order_list_widget.dart';
import 'package:provider/provider.dart';

/// A widget representing the Bartender's home screen.
/// Displays a list of orders and provides options to see one in particular.
class BarmanHomeWidget extends StatefulWidget {

  BarmanHomeWidget({super.key});

  ComService comService = ComService.getInstance();

  Future<ConnectionState> initialize_p2p_root() async {
    ConnectionState cs = await comService.init("OpenAirPOS", Role.bartender);
    comService.start();
    comService.startSocket();
    return cs;
  }

  @override
  State<BarmanHomeWidget> createState() => _BarmanHomeWidgetState();
}

class _BarmanHomeWidgetState extends State<BarmanHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: widget.initialize_p2p_root(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Consumer<OrderViewModel>(
                builder: (context, orderViewModel, child) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                        <Widget>[
                          HeaderContainer(
                              width: width
                          ),
                          Expanded(
                              child: OrderListView(orders: orderViewModel.orders)
                          )
                        ],
                  );
                }
              );
            } else {
              return LoaderWidget();
            }
          },
        ),
      ),
    );
  }
}
