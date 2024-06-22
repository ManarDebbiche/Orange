import 'package:flutter/material.dart';
import 'package:flutter_orange/screen/history_list_screen.dart';
import 'package:flutter_orange/screen/home_screen.dart';
import 'package:flutter_orange/screen/launch_list_screen.dart';
import 'package:flutter_orange/screen/mission_list_screen.dart';

class DetailLaunchScreen extends StatelessWidget {
  final dynamic launch;

  DetailLaunchScreen({required this.launch});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            launch['mission_name'],
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[200]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoItem('Mission Name:', launch['mission_name']),
                _buildInfoItem('Launch Date:', launch['launch_date_utc']),
                _buildInfoItem(
                    'Details:', launch['details'] ?? 'No details available'),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_missed_outlined),
              label: 'MISSION',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.launch),
              label: 'Launch',
            ),
          ],
          currentIndex: 2, 
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index) => _onItemTapped(context, index),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HistoryListScreen()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LaunchListScreen()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MissionListScreen()),
      );
    }
  }
}
