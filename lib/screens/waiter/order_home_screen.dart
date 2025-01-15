import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/screens/waiter/new_order_screen.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/containers/header_container_widget.dart';
import 'package:masi_dam_2425/widgets/order_list_widget.dart';
import 'package:provider/provider.dart';

class OrderHomeWidget extends StatefulWidget {
  ComService comService = ComService.getInstance();

  OrderHomeWidget({super.key});

  @override
  State<OrderHomeWidget> createState() => _OrderHomeWidgetState();
}

/// A widget representing the Waiter's home screen.
/// Displays a list of orders and provides option to add new ones.
class _OrderHomeWidgetState extends State<OrderHomeWidget> {
  @override
  Widget build(BuildContext context) {
    final OrderViewModel viewModel =
        Provider.of<OrderViewModel>(context, listen: true);
    // TODO : retrieve only active orders
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            buildHeaderContainer(width),
            SizedBox(height: 10),
            //TODO : add padding instead of sized box
            buildOrdersTitle(),
            buildOrdersList(viewModel),
            buildAddButton(width, context),
          ],
        )
      ),
    );
  }

  AddButton buildAddButton(double width, BuildContext context) {
    return AddButton(
      width: width,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewOrderWidget(),
          ),
        );
      },
      label: "Add new order",
      icon: Icons.border_color_outlined,
    );
  }

  Expanded buildOrdersList(OrderViewModel viewModel) {
    return Expanded(
      child: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.orders.isEmpty
              ? const Center(child: Text("No orders added yet."))
              : OrderListView(
                  orders: viewModel.orders,
                ),
    );
  }

  Row buildOrdersTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Orders",
            style: const TextStyle(
              fontSize: 30.0,
              color: LightColors.kDarkBlue,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  HeaderContainer buildHeaderContainer(double width) {
    return HeaderContainer(
      width: width,
    );
  }
}
