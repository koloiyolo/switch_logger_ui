import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> fetchlogs() async {
  var url = 'http://localhost:8003/';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return json.decode(response.body);
   
  } else {
    throw Exception(response.statusCode);
  }
}