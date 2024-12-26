import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/colored_container_widget.dart';

class OrderListView extends StatelessWidget {
  final List<Order> orders;

  const OrderListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderItem(
            orderNumber: orders.elementAt(index).getOrderNumber(),
            status: orders.elementAt(index).getStatus(),
            price: orders.elementAt(index).getTotalPrice());
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.0,
          thickness: 2,
          indent: 90,
          endIndent: 0,
          color: LightColors.kLightYellow2,
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets margin;
  final String status;
  final String tag;
  final double price;
  final int orderNumber;

  const OrderItem({
    super.key,
    this.height = 70,
    this.width = 150,
    this.margin = const EdgeInsets.symmetric(vertical: 1.0),
    required this.orderNumber,
    String? tag,
    required this.status,
    required this.price,
  }) : tag = tag ?? "Order $orderNumber";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildOrderNumber(),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTag(),
                buildOrderStatus(),
              ],
            ),
          ),
          buildPrice(),
        ],
      ),
    );
  }

  Text buildTag() {
    return Text(
      tag,
      style: const TextStyle(
        fontSize: 16.0,
        color: LightColors.kDarkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text buildPrice() {
    return Text(
      "\€$price",
      style: const TextStyle(
        fontSize: 20.0, // Plus grand
        color: LightColors.kDarkBlue,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Text buildOrderStatus() {
    return Text(status,
        style: const TextStyle(
          fontSize: 15.0,
          color: LightColors.kBlue,
          fontWeight: FontWeight.w500,
        ));
  }

  ColoredContainer buildOrderNumber() {
    return ColoredContainer(
      height: 40,
      width: 60,
      radius: 50,
      color: LightColors.kBlue,
      child:
      Center(
        child: Text(
          "#$orderNumber",
          style: const TextStyle(
            fontSize: 18,
            color: LightColors.kLightYellow,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
