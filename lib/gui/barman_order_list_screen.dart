import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';


class Order {
  String id;
  String table;
  String status;

  Order({
    required this.id,
    required this.table,
    required this.status
  });
}

class BarmanOrderListScreen extends StatefulWidget {
  ComService comService = ComService.getInstance();

  List<Order> orders = [
    Order(
      id: 'Order 1',
      table: 'Table 1',
      status: 'Pending'
    ),
    Order(
      id: 'Order 2',
      table: 'Table 2',
      status: 'Pending'
    ),
    Order(
      id: 'Order 3',
      table: 'Table 3',
      status: 'Pending'
    ),
    Order(
      id: 'Order 4',
      table: 'Table 4',
      status: 'Pending'
    ),
    Order(
      id: 'Order 5',
      table: 'Table 5',
      status: 'Pending'
    ),
    Order(
      id: 'Order 6',
      table: 'Table 6',
      status: 'Pending'
    ),
    Order(
      id: 'Order 7',
      table: 'Table 7',
      status: 'Pending'
    ),
    Order(
      id: 'Order 8',
      table: 'Table 8',
      status: 'Pending'
    ),
    Order(
      id: 'Order 9',
      table: 'Table 9',
      status: 'Pending'
    ),
    Order(
      id: 'Order 10',
      table: 'Table 10',
      status: 'Pending'
    ),
  ];

  @override
  State<BarmanOrderListScreen> createState() => _BarmanOrderListScreenState();
}

class _BarmanOrderListScreenState extends State<BarmanOrderListScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);

    return Scaffold(
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomTopContainer(
                  height: 150,
                  width: width,
                  title: 'Welcome Rodrigues',
                  subtitle: 'Bartender',
                ),
                Expanded(
                    child: ListView.builder(
                      itemCount: widget.orders.length,
                      itemBuilder: (context, index) {
                        return OrderItem(order: widget.orders[index]);
                      }
                    )
                )
              ],
            )
        )
    );
  }
}

class OrderItem extends StatelessWidget {
  final Order order;

  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(order.id),
          subtitle: Text(order.table),
          trailing: Text(order.status),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ModalBoxDialog(order: order);
          },
        );
      },
    );
  }
}

class ModalBoxDialog extends StatelessWidget {
  final Order order;

  ModalBoxDialog({required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Order ${order.id}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Table: ${order.table}'),
          Text('Status: ${order.status}'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Serve'),
          onPressed: () {
            order.status = 'Served';
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
