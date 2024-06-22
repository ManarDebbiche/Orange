import 'package:flutter/material.dart';
import 'package:flutter_orange/models/launch.dart';
import 'package:flutter_orange/service/api.dart';

class LaunchProvider with ChangeNotifier {
  List<Launch> _launches = [];
  Api _api = Api();

  List<Launch> get launches => _launches;

  Future<void> fetchLaunches() async {
    notifyListeners();
  }
}
