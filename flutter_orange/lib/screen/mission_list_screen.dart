import 'package:flutter/material.dart';
import 'package:flutter_orange/providers/mission_provider.dart';
import 'package:flutter_orange/screen/detaill_mission_screen.dart';
import 'package:flutter_orange/screen/home_screen.dart';
import 'package:flutter_orange/screen/launch_list_screen.dart';
import 'package:provider/provider.dart';

class MissionListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MissionProvider()..fetchAndSetMissions(),
      child: _MissionListScreenContent(),
    );
  }
}

class _MissionListScreenContent extends StatefulWidget {
  @override
  _MissionListScreenContentState createState() =>
      _MissionListScreenContentState();
}

class _MissionListScreenContentState extends State<_MissionListScreenContent> {
  late MissionProvider _missionProvider;
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _missionProvider = Provider.of<MissionProvider>(context);
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Missions',
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
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _missionProvider.filterMissions,
                  decoration: InputDecoration(
                    hintText: 'Search missions...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Consumer<MissionProvider>(
                  builder: (context, missionProvider, child) {
                    final missions = missionProvider.missions;
                    return missions.isEmpty
                        ? Center(child: Text('No missions available'))
                        : ListView.builder(
                            itemCount: missions.length,
                            itemBuilder: (context, index) {
                              final mission = missions[index];
                              return Card(
                                elevation: 3,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(
                                    mission.missionName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    mission.manufacturers?.join(', ') ??
                                        'No manufacturers available',
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMissionScreen(
                                                mission: mission),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
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
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
