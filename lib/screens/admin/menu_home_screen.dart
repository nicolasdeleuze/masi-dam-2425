import 'package:flutter/material.dart';
import 'package:masi_dam_2425/screens/admin/product_mgmt_screen.dart';
import 'package:masi_dam_2425/screens/admin/product_selection_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/theme/styles/textfield_style.dart';
import 'package:masi_dam_2425/view_model/menu_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:provider/provider.dart';

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {

  @override
  Widget build(BuildContext context) {
    final menuViewModel = Provider.of<MenuViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menus', style: extraBoldTitle()),
                  ElevatedButton.icon(
                      style: coloredButtonStyle(
                          LightColors.kBlue, LightColors.kLightYellow),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductManagementScreen(),
                          ),
                        );
                      },
                      label: Text("Manage Products"),
                      icon: Icon(
                        Icons.fastfood,
                        color: LightColors.kLightYellow,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                cursorColor: LightColors.kDarkBlue,
                decoration: cleanTextfieldStyle("Search menu", Icon(Icons.search)),
                onChanged: (value) {
                  // Action de recherche
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuViewModel.nbMenus,
                itemBuilder: (context, index) {
                  final menu = menuViewModel.menus.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Card(
                      color: LightColors.kLavender,
                      child: ListTile(
                        title: Text(
                          menu.name,
                          style: extraBoldText(),
                        ),
                        trailing: Text("${menu.nbProduct} products"),
                        onTap: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
            AddButton(
                width: MediaQuery.of(context).size.width,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductSelectionScreen(),
                    ),
                  );
                },
                label: 'Add a new menu',
                icon: Icons.restaurant_menu)
          ],
        ),
      ),
    );
  }
}

