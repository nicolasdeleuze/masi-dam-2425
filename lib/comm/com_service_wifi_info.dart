import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:masi_dam_2425/main.dart';

import 'com_service.dart';

class ComServiceWifiInfo extends StatefulWidget {
  ComServiceWifiInfo({super.key, required this.comService});

  ComService comService;

  @override
  State<ComServiceWifiInfo> createState() => _ComServiceWifiInfoState();
}

class _ComServiceWifiInfoState extends State<ComServiceWifiInfo> {

  WifiP2PInfo wifiP2PInfo = comService.getWifiP2PInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Wifi Info'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text('Is connected ${wifiP2PInfo.isConnected}'),
            Text('Group owner address ${wifiP2PInfo.groupOwnerAddress}'),
            Text('Group is formed ${wifiP2PInfo.groupFormed}'),
            Text('Clients : ${wifiP2PInfo.clients}'),
            const Spacer()
          ],
        ),
      ),
    );
  }
}