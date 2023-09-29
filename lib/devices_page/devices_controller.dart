import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:switch_logger_ui/logs_page/logs_rail.dart';

Future<Map> fetchdevices() async {
  var url = 'http://localhost:8003/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception(response.statusCode);
  }
}

void onTap(BuildContext context, String deviceName) {
  if (deviceName.isNotEmpty) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogsPage(deviceName: deviceName,)));
  }
}
