import 'package:flutter/material.dart';
import 'package:flutter_orange/models/mission.dart';
import 'package:flutter_orange/service/api.dart';

class MissionProvider extends ChangeNotifier {
  final Api _api = Api();
  List<Mission> _missions = [];
  List<Mission>? _filteredMissions;

  List<Mission> get missions => _filteredMissions ?? _missions;

  Future<void> fetchAndSetMissions() async {
    try {
      _missions = await _api.fetchMissions();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch missions: $e');
    }
  }

  void filterMissions(String query) {
    if (query.isNotEmpty) {
      _filteredMissions = _missions
          .where((mission) =>
              mission.missionName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _filteredMissions = null;
    }
    notifyListeners();
  }
}
