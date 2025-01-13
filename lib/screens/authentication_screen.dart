import 'package:flutter/material.dart';
import 'package:masi_dam_2425/screens/roles_selection_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/view_model/staff_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/add_button_widget.dart';
import 'package:provider/provider.dart';


// we need to be stateful because we modify the state of the text fields, so we need to keep track of the controllers
// and don't rebuild the whole widget
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Image.asset(
                        "assets/images/avatarMale.png",
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    buildTextField(
                      controller: firstnameController,
                      label: 'Enter firstname',
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 20.0),
                    buildTextField(
                      controller: lastnameController,
                      label: 'Enter lastname',
                      icon: Icons.person,
                    ),
                  ],
                ),
              ),
              AddButton(
                width: width,
                onPressed: () {
                  final firstname = firstnameController.text.trim();
                  final lastname = lastnameController.text.trim();
                  if (firstname.isEmpty || lastname.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter both firstname and lastname.')),
                    );
                    return;
                  }
                  final userId = userViewModel.createUser(firstname, lastname);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RolesWidget(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('User created with ID: $userId')),
                  );
                },
                label: "Connexion",
                icon: Icons.check,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      cursorColor: LightColors.kDarkBlue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: LightColors.kDarkBlue, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
