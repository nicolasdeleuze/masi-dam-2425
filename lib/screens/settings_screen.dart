
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/view_model/staff_view_model.dart';
import 'package:masi_dam_2425/screens/avatar_picker_screen.dart';
import 'package:masi_dam_2425/widgets/buttons/return_button_widget.dart';
import 'package:masi_dam_2425/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserViewModel userViewModel;

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    firstnameController.text = userViewModel.user!.firstname;
    lastnameController.text = userViewModel.user!.lastname;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserViewModel>(
        builder: (BuildContext context, UserViewModel value, Widget? child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Settings", style: extraBoldTitle(),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AvatarPickerScreen(currentAvatar: userViewModel.user!.avatarPath),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80.0),
                          child: Image.asset(
                            userViewModel.user!.avatarPath,
                            height: 100.0,
                            width: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTextField(
                          controller: firstnameController,
                          label: 'Enter firstname',
                          icon: Icons.person,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildTextField(
                          controller: lastnameController,
                          label: 'Enter lastname',
                          icon: Icons.person,
                      ),
                    ),
                    Spacer(),
                    ReturnButton(
                      width: MediaQuery.of(context).size.width,
                      onPressed: () {
                        String firstname = firstnameController.text.trim();
                        String lastname = lastnameController.text.trim();
                        if(firstname.isNotEmpty && lastname.isNotEmpty) {
                          userViewModel.updateUserFirstname(firstname);
                          userViewModel.updateUserLastname(lastname);
                          Navigator.pop(context);
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid username'),
                            ),
                          );
                        }
                      },
                      label: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
