import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/widgets/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/colored_container_widget.dart';
import 'package:provider/provider.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final TextEditingController _tagController = TextEditingController();
  final Order _currentOrder = Order();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ColoredContainer(
              height: 200,
              width: width,
              color: LightColors.kDarkYellow,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Create New Order",
                          style:
                              TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                                color: LightColors.kLightYellow
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    TextField(
                      controller: _tagController,
                      decoration: const InputDecoration(
                        labelText: "Optional Order Tag",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              color: LightColors.kRed,
                              iconSize: 40.0,
                            ),
                            Text(
                              "Cancel",
                              style: TextStyle(
                                  color: LightColors.kRed,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: LightColors.kGreen),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_currentOrder.products.isNotEmpty) {
                                  _currentOrder.setTag(_tagController.text);
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
                              icon: const Icon(Icons.check_circle_outline),
                              color: LightColors.kGreen,
                              iconSize: 40.0,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                      'Total price : €${_currentOrder.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20
                  ),),
                ),
              ],
            ),
            Expanded(
              child: _currentOrder.products.isEmpty
                  ? const Center(child: Text("No products added yet."))
                  : ListView.builder(
                      itemCount: _currentOrder.products.length,
                      itemBuilder: (context, index) {
                        final product = _currentOrder.products.elementAt(index);
                        final quantity =
                            _currentOrder.quantities.elementAt(index);
                        final price = product.price * quantity;

                        return ListTile(
                          title: Text(product.name,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: LightColors.kBlue)),
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
            ),
            AddButton(
                width: width,
                onPressed: () async {
                  final newProduct = await _showAddProductDialog(context);
                  if (newProduct != null) {
                    setState(() {
                      _currentOrder.addProduct(newProduct);
                    });
                  }
                },
                text: "Add new product")
          ],
        ),
      ),
    );
  }

  Future<Product?> _showAddProductDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final categoryController = TextEditingController();

    return showDialog<Product>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: "Category"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  final product = Product(
                    id: 1, // ID temp
                    name: nameController.text,
                    price: double.tryParse(priceController.text) ?? 0.0,
                    category: MenuCategory.juice,
                  );
                  Navigator.of(context).pop(product);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
