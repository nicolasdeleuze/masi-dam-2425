
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/theme/styles/text_style.dart';
import 'package:masi_dam_2425/view_model/staff_view_model.dart';
import 'package:masi_dam_2425/widgets/buttons/avatar_button_widget.dart';
import 'package:masi_dam_2425/widgets/buttons/return_button_widget.dart';
import 'package:provider/provider.dart';

class AvatarPickerScreen extends StatefulWidget {
  String currentAvatar = "assets/images/avatars/avatar_ungendered.png";

  AvatarPickerScreen({super.key, required this.currentAvatar});

  @override
  State<AvatarPickerScreen> createState() => _AvatarPickerScreenState();
}

class _AvatarPickerScreenState extends State<AvatarPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Choose avatar", style: extraBoldTitle(),),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.asset(
                widget.currentAvatar,
                height: 125.0,
                width: 125.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  AvatarButtonWidget(
                    onTap: () {
                      setState(() {
                        widget.currentAvatar = "assets/images/avatars/avatarMale.png";
                      });
                    },
                    avatarPath: "assets/images/avatars/avatarMale.png",
                  ),
                  AvatarButtonWidget(
                    onTap: () {
                      setState(() {
                        widget.currentAvatar = "assets/images/avatars/avatarFemale.png";
                      });
                    },
                    avatarPath: "assets/images/avatars/avatarFemale.png",
                  ),
                  AvatarButtonWidget(
                    onTap: () {
                      setState(() {
                        widget.currentAvatar = "assets/images/avatars/avatar_ungendered.png";
                      });
                    },
                    avatarPath: "assets/images/avatars/avatar_ungendered.png",
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ReturnButton(
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    UserViewModel userViewModel = Provider.of<UserViewModel>(context, listen: false);
                    userViewModel.updateAvatar(widget.currentAvatar);
                    Navigator.pop(context);
                  },
                  label: "Save"
              ),
            )
          ],
        ),
      ),
    );
  }
}

