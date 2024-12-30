import 'package:flutter/material.dart';
import 'package:masi_dam_2425/comm/com_service.dart';
import 'package:masi_dam_2425/comm/user_role.dart';
import 'package:masi_dam_2425/widgets/loader_widget.dart';
import 'package:masi_dam_2425/widgets/homepage_top_container_widget.dart';


class BarmanHomeWidget extends StatefulWidget {
  BarmanHomeWidget(
      {super.key}
  );

  ComService comService = ComService.getInstance();

  Future<ConnectionState> initialize_p2p_root() async {
    ConnectionState cs = await comService.init("OpenAirPOS", UserRole.barman);
    comService.start();
    comService.startSocket();
    return cs;
  }

  @override
  State<BarmanHomeWidget> createState() => _BarmanHomeWidgetState();
}

class _BarmanHomeWidgetState extends State<BarmanHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    widget.comService.setContext(context);
    return Scaffold(
      body: FutureBuilder(
        future: widget.initialize_p2p_root(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomTopContainer(
                  height: 150,
                  width: width,
                  title: 'Welcome Rodrigues',
                  subtitle: 'Bartender',
                ),
                Spacer()
              ],
            );
          } else {
            return LoaderWidget();
          }
        },
      ),
    );
  }
}
