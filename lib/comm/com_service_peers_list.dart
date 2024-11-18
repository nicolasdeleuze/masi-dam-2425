
import 'package:flutter/material.dart';
import 'package:masi_dam_2425/gui/theme.dart';

import 'com_service.dart';

class ComServicePeersList extends StatefulWidget {
  ComServicePeersList({super.key, required this.comService});

  ComService comService;

  @override
  State<ComServicePeersList> createState() => _ComServicePeersListState();
}

class _ComServicePeersListState extends State<ComServicePeersList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Peers'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO
                // List all available networks
                // make it selecteable
              },
              style: homeButtonStyle,
              child: const Text(
                'Join network',
                style: homeButtonTextStyle,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}