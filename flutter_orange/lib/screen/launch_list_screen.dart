import 'package:flutter/material.dart';
import 'package:flutter_orange/screen/detaill_launch_screen.dart';
import 'package:flutter_orange/screen/history_list_screen.dart';
import 'package:flutter_orange/screen/home_screen.dart';
import 'package:flutter_orange/screen/mission_list_screen.dart';
import 'package:flutter_orange/service/api.dart';
import 'package:intl/intl.dart';

class LaunchListScreen extends StatefulWidget {
  @override
  _LaunchListScreenState createState() => _LaunchListScreenState();
}

class _LaunchListScreenState extends State<LaunchListScreen> {
  final Api _api = Api();
  late Future<List<dynamic>> _launches;
  List<dynamic>? filteredLaunches;
  TextEditingController _searchController = TextEditingController();
  DateTime? selectedDate;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _launches = _api.fetchLaunches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterLaunches(DateTime? selectedDate) {
    if (selectedDate != null) {
      setState(() {
        _launches.then((launches) {
          filteredLaunches = launches
              .where((launch) => DateTime.parse(launch['launch_date_utc'])
                  .isAfter(selectedDate))
              .toList();
        });
      });
    } else {
      setState(() {
        filteredLaunches = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        filterLaunches(selectedDate);
      });
    }
  }

  void _onItemTapped(int index) {
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, //des back
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Launches',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () => _selectDate(context),
              icon: Icon(Icons.date_range),
              tooltip: 'Select Date',
            ),
          ],
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
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _launches,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Failed to load launches'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No launches available'));
                    } else {
                      List<dynamic> launches =
                          filteredLaunches ?? snapshot.data!;

                      return ListView.builder(
                        itemCount: launches.length,
                        itemBuilder: (context, index) {
                          final launch = launches[index];
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                launch['mission_name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(DateFormat('yyyy-MM-dd HH:mm')
                                  .format(DateTime.parse(
                                      launch['launch_date_utc']))),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailLaunchScreen(launch: launch),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
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
