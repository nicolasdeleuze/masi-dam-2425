import 'dart:math';

import 'package:masi_dam_2425/model/roles.dart';

class User {
  final String _id;
  String _firstname;
  String _lastname;
  final List<Role> _permissions;
  String _avatarPath;

  User(String firstname, String lastname, List<Role> permissions)
      : _id = _generateUserId(firstname, lastname),
        _firstname = firstname,
        _lastname = lastname,
        _permissions = permissions,
        _avatarPath = "assets/images/avatars/avatar_ungendered.png";

  static _generateUserId(String firstName, String lastName) {
    StringBuffer userId = StringBuffer();
    userId
        .write(firstName.substring(0, min(2, firstName.length)).toUpperCase());
    userId.write(lastName.substring(0, min(3, lastName.length)).toUpperCase());
    final random = Random();
    userId.write('${random.nextInt(9000) + 0000}');
    return userId.toString();
  }

  List<Role> get permissions => _permissions;
  String get lastname => _lastname;
  String get firstname => _firstname;
  String get id => _id;
  String get avatarPath => _avatarPath;

  void addRole(Role role) {
    if (!_permissions.contains(role)) {
      _permissions.add(role);
    }
  }

  void removeRole(Role role) {
    if (_permissions.contains(role)) {
      _permissions.remove(role);
    }
  }

  void updateFirstname(String firstname) {
    _firstname = firstname;
  }

  void updateLastname(String lastname) {
    _lastname = lastname;
  }

  void updateAvatar(String avatarPath) {
    _avatarPath = avatarPath;
  }
}
