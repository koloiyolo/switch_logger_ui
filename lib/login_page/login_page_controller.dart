import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switch_logger_ui/devices_page/devices_view.dart';


Future<void> submitLogin(BuildContext context, String username, String password) async {
    
    var url = Uri.parse('http://localhost:8001/?username=$username&password=$password');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Check the response content to determine success or failure
      if (response.body.contains('Hello')) {
        // Credentials are correct, navigate to the next screen
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) => const DevicesPage()));
      } else {
        // Credentials are incorrect, show an AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Authentication Failed'),
              content: const Text('Incorrect username or password.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Handle other HTTP status codes as needed
      print('HTTP Error: ${response.statusCode}');
    }
  }