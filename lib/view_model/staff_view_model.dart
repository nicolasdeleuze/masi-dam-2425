import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/roles.dart';
import 'package:masi_dam_2425/model/user.dart';

import 'package:flutter/material.dart';

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
}
