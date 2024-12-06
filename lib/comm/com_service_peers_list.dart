
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.comService.peers.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    // TODO
                    // select peer
                  },
                  child: Text(widget.comService.peers[index].deviceName),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}