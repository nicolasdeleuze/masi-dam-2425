import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/screens/waiter/order_%20product_selection.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/textfield_style.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/containers/colored_container_widget.dart';
import 'package:provider/provider.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';

class NewOrderWidget extends StatefulWidget {
  const NewOrderWidget({super.key});

  @override
  State<NewOrderWidget> createState() => _NewOrderWidgetState();
}

class _NewOrderWidgetState extends State<NewOrderWidget> {
  final TextEditingController _tagController = TextEditingController();
  Order _currentOrder = Order();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Consumer<OrderViewModel>(
        builder: (context, orderViewModel, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                buildHeaderContainer(width, context, orderViewModel),
                buildPriceDisplay(),
                buildProductsList(),
                buildAddButton(width, context)
              ],
            ),
          );
        }
      ),
    );
  }

  AddButton buildAddButton(double width, BuildContext context) {
    return AddButton(
      width: width,
      onPressed: () async {
        final updatedOrder = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrderProductSelectionScreen(currentOrder: _currentOrder),
          ),
        );

        if (updatedOrder != null && updatedOrder is Order) {
          setState(() {
            _currentOrder = updatedOrder;
          });
        }
      },
      label: "Add new product(s)",
      icon: Icons.fastfood,
    );
  }

  Row buildPriceDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            'Total €${_currentOrder.price}',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
          ),
        ),
      ],
    );
  }

  ColoredContainer buildHeaderContainer(
      double width, BuildContext context, OrderViewModel orderViewModel) {
    return ColoredContainer(
      height: 180,
      width: width,
      color: LightColors.kDarkYellow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Create order",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: LightColors.kGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 45,
                  width: 45,
                  child: Center(
                    child: Text(
                      _currentOrder.products.length.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: LightColors.kLightYellow),
                    ),
                  ),
                )
              ],
            ),
            TextField(
              controller: _tagController,
              decoration: underlinedTextfieldStyle("Add optional order tag",
                  Icon(Icons.drive_file_rename_outline)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.cancel,
                    color: LightColors.kLightYellow,
                    size: 20.0,
                  ),
                  label: Text(
                    "Cancel",
                    style: TextStyle(
                        color: LightColors.kLightYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColors.kRed,
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.check_circle,
                    color: LightColors.kLightYellow,
                    size: 20.0,
                  ),
                  label: Text(
                    'Send',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: LightColors.kLightYellow),
                  ),
                  onPressed: () {
                    if (_currentOrder.products.isNotEmpty) {
                      if (_tagController.text.isNotEmpty) {
                        _currentOrder.setTag(_tagController.text);
                      }
                      orderViewModel.createOrder(_currentOrder);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Please add at least one product to the order.")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LightColors.kGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildProductsList() {
    return Expanded(
      child: _currentOrder.products.isEmpty
          ? const Center(child: Text("No products added yet."))
          : ListView.builder(
              itemCount: _currentOrder.products.length,
              itemBuilder: (context, index) {
                final product = _currentOrder.products.elementAt(index);
                final quantity = _currentOrder.quantities.elementAt(index);
                final price = product.price * quantity;

                return ListTile(
                  title: Text(product.name,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: LightColors.kDarkBlue)),
                  subtitle: Text(
                      "Quantity: $quantity  |  price : €${price.toStringAsFixed(2)}"),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            _currentOrder.removeProduct(product);
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _currentOrder.addProduct(product);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
