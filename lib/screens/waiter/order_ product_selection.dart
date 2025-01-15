import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/order.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/theme/styles/textfield_style.dart';
import 'package:masi_dam_2425/view_model/menu_view_model.dart';
import 'package:masi_dam_2425/view_model/order_view_model.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/category_selection_widget.dart';
import 'package:provider/provider.dart';

class OrderProductSelectionScreen extends StatefulWidget {
  final Order currentOrder;

  const OrderProductSelectionScreen({super.key, required this.currentOrder});

  @override
  State<OrderProductSelectionScreen> createState() => _OrderProductSelectionScreenState();
}

class _OrderProductSelectionScreenState extends State<OrderProductSelectionScreen> {
  late Order _currentOrder;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.currentOrder!;
    controller = TextEditingController(text: "");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add Product(s)',
                    style: extraBoldTitle(),
                  ),
                ],
              ),
            ),
            _buildSearchField(productViewModel),
            CategorySelectionWidget(productViewModel: productViewModel),
            Expanded(
              child: _buildProductList(productViewModel),
            ),
            _buildActionButtons(context, orderViewModel),
          ],
        ),
      ),
    );
  }

  Padding _buildSearchField(ProductViewModel productViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: TextField(
        cursorColor:  LightColors.kDarkBlue,
        decoration: cleanTextfieldStyle("Search product", Icon(Icons.search)),
        onChanged: (value) {
          productViewModel.getProductsByName(value);
        },
      ),
    );
  }

  Widget _buildProductList(ProductViewModel productViewModel) {
    if (productViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (productViewModel.products.isEmpty) {
      return const Center(child: Text("No products added yet."));
    } else {
      return ListView.builder(
        itemCount: productViewModel.nbProducts,
        itemBuilder: (context, index) {
          final product = productViewModel.products[index];
          bool isSelected = _currentOrder.contains(product);

          return ProductCard(
            product: product,
            onSelect: (isSelected) {
              setState(() {
                if (isSelected != null && isSelected) {
                  _currentOrder.addProduct(product);
                } else {
                  _currentOrder.removeProduct(product);
                }
              });
            },
            isSelected: isSelected,
          );
        },
      );
    }
  }

  Widget _buildActionButtons(
      BuildContext context, OrderViewModel orderViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddButton(
          width: MediaQuery.of(context).size.width,
          onPressed: () {
            if (_currentOrder.isEmpty()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Select at least one product")),
              );
              return;
            }
            //TODO : add product to order
            Navigator.of(context).pop(_currentOrder);
          },
          label: "Add product(s)",
          icon: Icons.check,
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final ValueChanged<bool?> onSelect;
  final bool isSelected;

  const ProductCard({
    super.key,
    required this.product,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Card(
        color: LightColors.kLightGreen,
        child: ListTile(
          title: Text(product.name, style: extraBoldText()),
          subtitle: Text("Price: €${product.price}\n"
              "Category: ${product.category.displayName}"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: isSelected,
                onChanged: onSelect,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
