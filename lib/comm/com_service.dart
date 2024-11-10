import 'dart:io';
import 'dart:async';
import 'dart:isolate';

import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';

import 'user_role.dart';

class ComService {
  String? _networkName;
  UserRole? _role;
  FlutterP2pConnection? _connection;

  ComService() {
    _connection = FlutterP2pConnection();
  }

  void init(String networkName, UserRole role) async {
    _networkName = networkName;
    _role = role;

    // check authorization
    int isAllAuthorized = 0;
    do {
      isAllAuthorized = 0;

      if(await _connection!.checkLocationEnabled())
        isAllAuthorized++;
      else
        await _connection!.askLocationPermission();

      if(await _connection!.checkStoragePermission())
        isAllAuthorized++;
      else
        await _connection!.askStoragePermission();

      if(await _connection!.checkWifiEnabled())
        isAllAuthorized++;
      else {
        if(await _connection!.enableWifiServices())
          isAllAuthorized++;
      }

    } while(isAllAuthorized != 3);

    await _connection!.initialize();
    await _connection!.register();
  }

  void start() {
    if (_role == UserRole.barman) {
      startAsBarman(_networkName!);
    } else if (_role == UserRole.waiter) {
      startAsWaiter(_networkName!);
    }
  }

  void stop() {
    _connection!.removeGroup();
  }

  void startAsBarman(String networkName) {
  }

  void startAsWaiter(String networkName) {
  }
}