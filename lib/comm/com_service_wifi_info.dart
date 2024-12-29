// import 'package:flutter/material.dart';
// import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
//
// import 'com_service.dart';

// class ComServiceWifiInfo extends StatefulWidget {
//   ComServiceWifiInfo({super.key});
//
//   ComService comService = ComService.getInstance();
//
//   @override
//   State<ComServiceWifiInfo> createState() => _ComServiceWifiInfoState();
// }
//
// class _ComServiceWifiInfoState extends State<ComServiceWifiInfo> {
//   @override
//   Widget build(BuildContext context) {
//     late WifiP2PInfo wifiP2PInfo;
//
//     return FutureBuilder(
//       future: () async {
//         wifiP2PInfo = widget.comService.getWifiP2PInfo();
//       }(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text('Group Owner Address: ${wifiP2PInfo.groupOwnerAddress}'),
//               Text('Is Group Owner: ${wifiP2PInfo.isGroupOwner}')
//             ],
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }