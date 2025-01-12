import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/menu_category.dart';
import 'package:masi_dam_2425/view_model/product_view_model.dart';

class CategorySelectionWidget extends StatelessWidget {
  final ProductViewModel productViewModel;

  const CategorySelectionWidget({super.key, required this.productViewModel });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: MenuCategoryExtension.nbCategory,
          itemBuilder: (context, index) {
            final category = MenuCategory.values.elementAt(index);
            return ElevatedButton(
              onPressed: () {
                productViewModel.selectCategory(category);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  elevation: 0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: Image.asset(
                      "assets/images/productIcons/${category.iconName}",
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(category.displayName)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}