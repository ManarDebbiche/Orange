import 'package:flutter/material.dart';
import 'package:flutter_orange/screen/history_list_screen.dart';
import 'package:flutter_orange/screen/launch_list_screen.dart';
import 'package:flutter_orange/screen/mission_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey[200]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60), // Adjust the height as needed

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person, size: 40, color: Colors.black), // User icon
                SizedBox(width: 10),
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 40), // Adjust the height as needed

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                padding: EdgeInsets.all(20),
                children: [
                  buildGridItem(
                    context,
                    Icons.launch,
                    'LAUNCHES',
                    LaunchListScreen(),
                  ),
                  buildGridItem(
                    context,
                    Icons.call_missed,
                    'MISSIONS',
                    MissionListScreen(),
                  ),
                  buildGridItem(
                    context,
                    Icons.history,
                    'HISTORY',
                    HistoryListScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(
      BuildContext context, IconData icon, String label, Widget destination) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => destination));
      },
      icon: Icon(icon),
      label: Text(label),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    );
  }
}
