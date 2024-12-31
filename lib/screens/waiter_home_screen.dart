import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/comm/com_service_peers_list.dart';
import 'package:masi_dam_2425/repository/app_repository.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/view_model/view_model.dart';
import 'package:masi_dam_2425/view_model/observer.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/status.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/widgets/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/order_widget.dart';
import 'package:masi_dam_2425/widgets/loader_widget.dart';

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
class _WaiterHomeWidgetState extends State<WaiterHomeWidget> implements EventObserver {
  final OrderViewModel _viewModel = OrderViewModel(AppRepository());
  bool _isLoading = false;
  List<Order> _orders = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

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
                      orders: _orders,
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

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is OrdersLoadedEvent) {
      setState(() {
        _orders = event.orders;
      });
    }
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
                // TODO add order
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
