import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/theme/styles/textfield_style.dart';
import 'package:masi_dam_2425/view_model/menu_view_model.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/category_selection_widget.dart';
import 'package:provider/provider.dart';

class ProductSelectionScreen extends StatefulWidget {
  const ProductSelectionScreen({super.key});

  @override
  State<ProductSelectionScreen> createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
  List<Product> selectedProducts = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
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
    final menuViewModel = Provider.of<MenuViewModel>(context);

    // width = MediaQuery.of(context).size.width - size of the text "Name" - size of the padding
    var widthEnterName = MediaQuery.of(context).size.width - "Name".length * 25 - 32;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'New Menu',
                    style: extraBoldTitle(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: LightColors.kDarkYellow,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: widthEnterName,
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.text,
                        cursorColor:  LightColors.kDarkBlue,
                        decoration: cleanTextfieldStyle("enter name", null),
                        ),
                      ),

                  ],
                ),
              ),
            ),
            _buildSearchField(productViewModel),
            CategorySelectionWidget(productViewModel: productViewModel),
            Expanded(
              child: _buildProductList(productViewModel),
            ),
            _buildActionButtons(context, menuViewModel),
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
          bool isSelected = selectedProducts.contains(product);

          return ProductCard(
            product: product,
            onSelect: (isSelected) {
              setState(() {
                if (isSelected != null && isSelected) {
                  selectedProducts.add(product);
                } else {
                  selectedProducts.remove(product);
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
      BuildContext context, MenuViewModel menuViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddButton(
          width: MediaQuery.of(context).size.width,
          onPressed: () {
            String menuName = controller.text.trim();

            if (menuName.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Menu name cannot be empty")),
              );
              return;
            }
            if (selectedProducts.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Select at least one product")),
              );
              return;
            }

            menuViewModel.createMenu(
                Menu(name: menuName, products: selectedProducts.toList()));
            Navigator.of(context).pop();
          },
          label: "Validate new menu",
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
