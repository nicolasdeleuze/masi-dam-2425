import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/model/user.dart';


class UserViewModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  UserViewModel();

  String createUser(String firstname, String lastname) {
    List<Role> defaultPermissions = [Role.admin, Role.bartender, Role.waiter];
    _user = User(firstname, lastname, defaultPermissions);
    notifyListeners();
    return _user!.id;
  }

  void updateUserFirstname(String text) {
    if (text != _user!.firstname) {
      _user!.updateFirstname(text);
      notifyListeners();
    }
  }
  void updateUserLastname(String text) {
    if (text != _user!.lastname) {
      _user!.updateLastname(text);
      notifyListeners();
    }
  }

  void updateAvatar(currentAvatar) {
    if (currentAvatar != _user!.avatarPath) {
      _user!.updateAvatar(currentAvatar);
      notifyListeners();
    }
  }
}
