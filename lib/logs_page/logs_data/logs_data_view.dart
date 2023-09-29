import 'package:flutter/material.dart';
import 'logs_data_controller.dart';

class LogsData extends StatefulWidget {
  final String deviceName;

  const LogsData({required this.deviceName, super.key});

  @override
  State<LogsData> createState() => _LogsDataState();
}

class _LogsDataState extends State<LogsData> {
  late Future<Map> flogs;

  @override
  void initState() {
    flogs = fetchlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: flogs,
      builder: ((context, snapshot) {
        var deviceName = widget.deviceName;
        if (snapshot.hasData) {
          return LogView(deviceName: deviceName, snapshot: snapshot);
        } else if (snapshot.hasError) {
          Text('${snapshot.error}');
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class LogView extends StatelessWidget {
  const LogView({super.key, required this.deviceName, required this.snapshot});

  final String deviceName;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(child: GestureDetector(child: const Wrap(children: [Text("Date"), Icon(Icons.arrow_drop_up_rounded) /*Icon(Icons.arrow_drop_down_rounded) */],)),),
              SizedBox(child: GestureDetector(child: const Wrap(children: [Text("Error"), Icon(Icons.arrow_drop_up_rounded) /*Icon(Icons.arrow_drop_down_rounded) */],)),),
            ],
          ),
          Flexible(
            child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data![deviceName].length,
                itemBuilder: ((context, index) {
                  var log = snapshot.data![deviceName];
                  return ExpansionTile(
                    title: Text(
                        "Date: ${log[index]["datetime"]}        Error Code: ${log[index]["error"]}"),
                    children: [
                      ListTile(
                          title:
                              Text("Description ${log[index]["description"]}"))
                    ],
                  );
                })),
          ),
        ],
      ),
    );
  }
}
