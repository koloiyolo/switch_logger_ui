import 'package:flutter/material.dart';

import 'devices_controller.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  late Future<Map> fdevices;

  @override
  void initState() {
    super.initState();
    fdevices = fetchdevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, title: const Text("Your devices chuju")),
      body: FutureBuilder(
        future: fdevices,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            int count = snapshot.data!['deviceCount'];
            List<Map> devices = [];
            for (int i = 0; i < count; i++) {
              devices.add(snapshot.data!["$i"]);
            }
            return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                ),
                itemCount: count,
                itemBuilder: ((context, index) {
                  return deviceTile(devices, index, context);
                }));
          } else if (snapshot.hasError) {
            Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget deviceTile(
      List<Map<dynamic, dynamic>> devices, int index, BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.router_outlined),
            title: Text('Name: ${devices[index]['name']}'),
            onTap: () => onTap(context, devices[index]['name']),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('IP: ${devices[index]['ipv4']}'),
                Text('Model: ${devices[index]['router']}'),
                Text('Last log: ${devices[index]['last_log_datetime']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
