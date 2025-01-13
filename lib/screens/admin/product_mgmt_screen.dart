import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/model/product.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/theme/styles/textfield_style.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:masi_dam_2425/widgets/category_selection_widget.dart';
import 'package:provider/provider.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

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
                    'Products',
                    style: extraBoldTitle(),
                  ),
                ],
              ),
            ),
            _buildSearchField(productViewModel),
            CategorySelectionWidget(productViewModel : productViewModel),
            Expanded(
              child: _buildProductList(productViewModel),
            ),
            _buildActionButtons(context, productViewModel),
          ],
        ),
      ),
    );
  }

  Padding _buildSearchField(ProductViewModel productViewModel) {
    return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
            child: TextField(
              cursorColor: LightColors.kDarkBlue,
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
        itemCount: productViewModel.products.length,
        itemBuilder: (context, index) {
          final product = productViewModel.products.elementAt(index);
          return ProductCard(
            product: product,
            onEdit: () =>
                _showEditProductDialog(context, product, productViewModel),
            onDelete: () => productViewModel.deleteProduct(product),
          );
        },
      );
    }
  }

  Widget _buildActionButtons(
      BuildContext context, ProductViewModel productViewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AddButton(
            width: MediaQuery.of(context).size.width,
            onPressed: () => _showAddProductDialog(context, productViewModel),
            label: "Add new product",
            icon: Icons.fastfood)
      ],
    );
  }

  void _showAddProductDialog(
      BuildContext context, ProductViewModel productViewModel) {
    _showProductDialog(
      context,
      "Add Product",
      null,
      (product) => productViewModel.createProduct(product),
    );
  }

  void _showEditProductDialog(BuildContext context, Product product,
      ProductViewModel productViewModel) {
    _showProductDialog(
      context,
      "Edit Product",
      product,
      (product) => productViewModel.updateProduct(product),
    );
  }

  void _showProductDialog(BuildContext context, String title, Product? product,
      Function(Product) onSubmit) {
    showDialog(
      context: context,
      builder: (context) => AddOrEditProductDialog(
        title: title,
        product: product,
        onSubmit: onSubmit,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
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
              IconButton(
                icon: const Icon(Icons.edit_note,
                    color: LightColors.kGreen, size: 30),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: LightColors.kRed),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddOrEditProductDialog extends StatefulWidget {
  final String title;
  final Product? product;
  final Function(Product) onSubmit;

  const AddOrEditProductDialog({
    super.key,
    required this.title,
    this.product,
    required this.onSubmit,
  });

  @override
  State<AddOrEditProductDialog> createState() => _AddOrEditProductDialogState();
}

class _AddOrEditProductDialogState extends State<AddOrEditProductDialog> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late MenuCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? "");
    priceController =
        TextEditingController(text: widget.product?.price.toString() ?? "");
    selectedCategory = widget.product?.category ?? MenuCategory.soft;
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: LightColors.kLightGreen,
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nameController, "Product Name"),
            _buildTextField(priceController, "Price", isNumeric: true),
            _buildCategoryDropdown(),
          ],
        ),
      ),
      actions: _buildDialogActions(context),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      {bool isNumeric = false}) {
    return TextField(
      cursorColor : LightColors.kDarkBlue,
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: underlinedTextfieldStyle(hint, null),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<MenuCategory>(
      value: selectedCategory,
      onChanged: (newCategory) {
        setState(() {
          selectedCategory = newCategory;
        });
      },
      decoration: underlinedTextfieldStyle("Category", null),
      items: MenuCategory.values.map((category) {
        return DropdownMenuItem<MenuCategory>(
          value: category,
          child: Text(category.displayName.split('.').last),
        );
      }).toList(),
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text("Cancel", style: extraBoldText()),
      ),
      TextButton(
        onPressed: () {
          if (nameController.text.isNotEmpty &&
              priceController.text.isNotEmpty) {
            final product = Product(
              id: widget.product?.id,
              name: nameController.text,
              price: double.tryParse(priceController.text) ?? 0.0,
              category: selectedCategory!,
            );
            widget.onSubmit(product);
            Navigator.of(context).pop();
          }
        },
        child: Text(widget.title == "Add Product" ? "Add" : "Edit",
            style: extraBoldText()),
      ),
    ];
  }
}

