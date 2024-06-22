//import 'package:flutter/material.dart';
//import 'package:flutter_orange/screen/home_screen.dart';
//import 'package:flutter_orange/screen/list_history_screen.dart'; 
//import 'package:flutter_orange/screen/mission_list_screen.dart'; 
//import 'package:flutter_orange/service/api.dart';
//import 'package:dio/dio.dart';
//import 'package:get/get.dart';
//import 'package:intl/intl.dart';

//class ListScreenController extends GetxController {
  //final Dio _dio = Dio(); // Instance de Dio pour les requêtes HTTP
  //final Api _api = Api(); // Votre classe Api existante

  //late RxBool isLoading = true.obs;
  //late RxList<Map<String, dynamic>> launches = <Map<String, dynamic>>[].obs;
  //late RxList<Map<String, dynamic>> filteredLaunches =
    //  <Map<String, dynamic>>[].obs;
  //late TextEditingController searchController = TextEditingController();
  //late Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  //late RxInt selectedIndex = 0.obs;

  //@override
  //void onInit() {
    //super.onInit();
    //fetchLaunches();
  //}

  //Future<void> fetchLaunches() async {
    //try {
      //isLoading.value = true;
      //List data = await _api.fetchLaunches();
      //if (data.isNotEmpty) {
        //launches.assignAll(data);
        //filterLaunches(selectedDate.value);
      //} else {
        //launches.clear();
      //}
    //} catch (e) {
      //print('Error fetching launches: $e');
      //launches.clear();
    //} finally {
      //isLoading.value = false;
    //}
  //}

  //void filterLaunches(DateTime? selectedDate) {
    //if (selectedDate != null) {
      //filteredLaunches.value = launches
        //  .where((launch) =>
          //    DateTime.parse(launch['launch_date_utc']).isAfter(selectedDate))
          //.toList();
    //} else {
      //filteredLaunches.value = launches;
    //}
  //}

  //Future<void> selectDate(BuildContext context) async {
    //final DateTime? picked = await showDatePicker(
      //context: context,
      //initialDate: selectedDate.value ?? DateTime.now(),
      //firstDate: DateTime(2010),
      //lastDate: DateTime(2100),
    //);
    //if (picked != null && picked != selectedDate.value) {
      //selectedDate.value = picked;
      //filterLaunches(selectedDate.value);
    //}
  //}

  //void onItemTapped(int index) {
    //switch (index) {
      //case 0:
        //Get.offAll(() => HomeScreen());
        //break;
      //case 1:
        //Get.offAll(() => ListHistoryScreen());
        //break;
      //case 2:
        //Get.offAll(() =>
          //  ListScreen()); // Replace with the correct screen if this is not self-referencing
        //break;
      //case 3:
        //Get.offAll(() => MissionListScreen());
        //break;
      //default:
        //break;
    //}
    //selectedIndex.value = index;
  //}

  //@override
  //void onClose() {
    //searchController.dispose();
    //super.onClose();
  //}
//}
