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
          price : orders.elementAt(index).calculateTotalPrice()
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.0,
          thickness: 1.0,
          color: Colors.grey,
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
  final double price;
  final String orderIconPath;
  final int orderNumber;

  const OrderItem({
    super.key,
    this.height = 70,
    this.width = 150,
    this.margin = const EdgeInsets.symmetric(vertical: 1.0),
    required this.orderNumber,
    required this.status,
    required this.price,
    this.orderIconPath = "assets/images/product.png",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildOrderNumber(),
          const SizedBox(width: 15.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPriceTag(),
              buildOrderStatus(),
            ],
          ),
        ],
        )
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

  Text buildPriceTag() {
    return Text("$price \$",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: LightColors.kDarkBlue,
                  fontWeight: FontWeight.w800,
                ));
  }

  ColoredContainer buildOrderNumber() {
    return ColoredContainer(
          height : 40,
          width: 100,
          radius: 50,
          color: LightColors.kBlue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                orderIconPath,
                height: 25,
                width: 25,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "#$orderNumber",
                style: const TextStyle(
                  fontSize: 18,
                  color: LightColors.kLightYellow,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );
  }
}
