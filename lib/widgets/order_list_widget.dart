import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/widgets/containers/colored_container_widget.dart';

class OrderListView extends StatelessWidget {
  final List<Order> orders;

  const OrderListView({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return OrderOverview(order: orders.elementAt(index));
              },
            );
          },
          child: OrderItem(
              orderNumber: index + 1,
              tag: orders.elementAt(index).tag,
              status: orders.elementAt(index).statusToString,
              price: orders.elementAt(index).price),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.0,
          thickness: 2,
          indent: 90,
          endIndent: 0,
          color: LightColors.kLightGreen,
        );
      },
    );
  }
}

class OrderOverview extends StatelessWidget {
  final Order order;

  const OrderOverview({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: LightColors.kLightYellow,
        ),
        clipBehavior: Clip.antiAlias,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                        children:
                        [
                          Row(
                            children: [
                              Text("Order ${order.id}", style: extraBoldTitle(),),
                            ],
                          ),
                          _buildOrderDetails(label: "Status : ", value: "${order.statusToString}"),
                          _buildOrderDetails(label: "Price : ", value: "${order.price}"),
                          Divider(),
                          _buildProductListOrderDetails(order: order)
                        ]
                    )
                ),
                _buildActionButtonOrderDetails(order: order, context: context),
              ]
            ),
          )
        ),
      ),
    );
  }
}

Widget _buildOrderDetails({required String label, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      Text(value, style: TextStyle(fontSize: 16),),
    ],
  );
}

Widget _buildProductListOrderDetails({required Order order}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Product", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          Text("Quantity", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        ],
      ),
      ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: order.products.length,
        itemBuilder: (context, index) {
          Product prod = order.products.elementAt(index);
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(prod.name, style: TextStyle(fontSize: 16),),
              Text("${order.quantities.elementAt(index)}", style: TextStyle(fontSize: 16),),
            ],
          );
        },
      ),
    ],
  );
}

Widget _buildActionButtonOrderDetails({required Order order, required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton.icon(
        onPressed: () {
          order.prepared();
        },
        style: coloredButtonStyle(
            LightColors.kBlue, LightColors.kLightYellow),
        label: const Text(
          "Mark as prepared",
          style: coloredButtonTextStyle,
        ),
      ),
      ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
        },
        style: coloredButtonStyle(
            LightColors.kBlue, LightColors.kLightYellow),
        label: const Text(
          "Cancel",
          style: coloredButtonTextStyle,
        ),
      )
    ],
  );
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
      "€$price",
      style: const TextStyle(
        fontSize: 20.0,
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
      color: LightColors.kGreen,
      child: Center(
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
