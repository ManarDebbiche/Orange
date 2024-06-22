import 'package:flutter_orange/models/mission.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_orange/models/history.dart';
import 'dart:convert';

class Api {
  static const String baseUrl = 'https://api.spacexdata.com/v3';

  Future<List<dynamic>> fetchLaunches() async {
    var box = await Hive.openBox('launchesBox');
    if (box.isNotEmpty) {
      return box.values.toList();
    }

    final response = await http.get(Uri.parse('$baseUrl/launches'));
    if (response.statusCode == 200) {
      final launches = json.decode(response.body);
      for (var launch in launches) {
        box.add(launch);
      }
      return launches;
    } else {
      throw Exception('Failed to load launches');
    }
  }

  Future<List<Mission>> fetchMissions() async {
    final response = await http.get(Uri.parse('$baseUrl/missions'));

    if (response.statusCode == 200) {
      final List<dynamic> missionJson = json.decode(response.body);
      final List<Mission> missions =
          missionJson.map((json) => Mission.fromJson(json)).toList();
      return missions;
    } else {
      throw Exception('Failed to load missions');
    }
  }

  Future<List<HistoryEvent>> fetchHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/history'));
    if (response.statusCode == 200) {
      final List<dynamic> historyJson = jsonDecode(response.body);
      final List<HistoryEvent> historyEvents =
          historyJson.map((json) => HistoryEvent.fromJson(json)).toList();
      return historyEvents;
    } else {
      throw Exception('Failed to load history');
    }
  }
}
