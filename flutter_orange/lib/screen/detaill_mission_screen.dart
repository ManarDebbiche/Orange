import 'package:flutter/material.dart';
import 'package:flutter_orange/models/mission.dart';
import 'package:flutter_orange/screen/history_list_screen.dart';
import 'package:flutter_orange/screen/home_screen.dart';
import 'package:flutter_orange/screen/launch_list_screen.dart';
import 'package:flutter_orange/screen/mission_list_screen.dart';

class DetailMissionScreen extends StatelessWidget {
  final Mission mission;

  DetailMissionScreen({required this.mission});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            mission.missionName,
            style: TextStyle(color: Colors.black),
          ),
          leading: null,
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
                _buildInfoItem(
                  'Mission Name:',
                  mission.missionName,
                ),
                _buildInfoItem(
                  'Manufacturers:',
                  mission.manufacturers?.join(', ') ??
                      'No manufacturers available',
                ),
                _buildInfoItem(
                  'Payload IDs:',
                  mission.payloadIds?.join(', ') ?? 'No payload IDs available',
                ),
                _buildInfoItem(
                  'Wikipedia:',
                  mission.wikipedia ?? 'No Wikipedia link available',
                ),
                _buildInfoItem(
                  'Description:',
                  mission.description ?? 'No description available',
                ),
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
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
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
          },
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
}
