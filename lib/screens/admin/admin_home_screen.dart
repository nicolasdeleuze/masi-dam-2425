import 'package:flutter/material.dart';
import 'package:masi_dam_2425/model/event.dart';
import 'package:masi_dam_2425/model/menu.dart';
import 'package:masi_dam_2425/screens/admin/menu_home_screen.dart';
import 'package:masi_dam_2425/theme/colors/light_colors.dart';
import 'package:masi_dam_2425/theme/styles/colored_button_style.dart';
import 'package:masi_dam_2425/widgets/containers/header_container_widget.dart';
import 'package:intl/intl.dart';
import 'package:masi_dam_2425/widgets/buttons/square_button.dart';

/// A widget representing the Administrator's home screen.
/// Displays a list of events and provides tools for managing them.
class AdminHomeWidget extends StatefulWidget {
  const AdminHomeWidget({super.key});

  @override
  State<AdminHomeWidget> createState() => _AdminHomeWidgetState();
}

class _AdminHomeWidgetState extends State<AdminHomeWidget> {
  final List<Event> _events = [
    Event(
      DateTime(2024, 12, 26, 18, 30),
      null,
      'Christmas Market',
      'City Center',
      Menu(name:'',products: null),
      [],
    ),
    Event(
      DateTime(2024, 12, 31, 20, 00),
      null,
      'New Year Eve',
      'Grand Hall',
      Menu(name:'',products: null),
      [],
    ),
  ];


  @override
  Widget build(BuildContext context) {

    String searchQuery = "";

    double width = MediaQuery.of(context).size.width;
    double padding = 16.0;
    double titleFontSize = 30;

    final List<SquareButton> buttons = [
      SquareButton(label: "Events", icon: Icons.event, color: LightColors.kBlue, onPressed: () {}),
      SquareButton(label: "Stats", icon: Icons.bar_chart, color: LightColors.kDarkYellow, onPressed: () {}),
      SquareButton(label: "Teams", icon: Icons.group, color: LightColors.kRed, onPressed: () {}),
      SquareButton(label: "Menus", icon: Icons.menu_book, color: LightColors.kGreen, onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminMenuScreen(),
          ),
        );
      },),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderContainer(
              width: width,
              subtitle: 'Event Admin',
              userID: "RLE1234",
            ),
            Padding(
              padding: EdgeInsets.only(left: padding, right: padding, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events',
                    style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.w900),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to the create event screen
                    },
                    style: coloredButtonStyle(
                        LightColors.kBlue, LightColors.kLightYellow),
                    label: const Text(
                      'Create New Event',
                      style: coloredButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _events.length,
                itemBuilder: (context, index) {
                  final event = _events[index];
                  return Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: 250,
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: LightColors.kLavender,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              event.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                              icon: const Icon(Icons.more_horiz,
                                  color: LightColors.kDarkBlue),
                              onPressed: () {
                                // TODO: Navigate to event editor
                              },
                            )
                          ],
                        ),
                        Text('Location: ${event.location}'),
                        Text(
                            'Date: ${DateFormat('dd/MM/yyyy').format(event.start)}'),
                        if (event.end != null)
                          Text(
                              'End: ${DateFormat('dd/MM/yyyy').format(event.end!)}'),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildInfoChip('${event.orders?.length ?? 0}','Orders',LightColors.kBlue),
                            buildInfoChip('${event.staff.length}', 'Staff', Colors.blue)
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(padding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return buttons[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildInfoChip(String data, String dataName, Color color) {
    return Container(
      height: 70,
      width: 90,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data,
            style: TextStyle(
                color: LightColors.kLightYellow,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            dataName,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: LightColors.kLightYellow),
          ),
        ],
      ),
    );

  }
}


