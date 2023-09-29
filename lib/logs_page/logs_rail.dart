import 'package:flutter/material.dart';
import 'package:switch_logger_ui/logs_page/logs_data/logs_data_view.dart';

class LogsPage extends StatefulWidget {
  final String deviceName;

  const LogsPage({required this.deviceName, super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  int _selectedIndex = 0;
  Widget page = const Placeholder();

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        page = LogsData(deviceName: widget.deviceName);
        break;
      case 1:
        page = const Placeholder();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.deviceName}\'s info'),
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.notes_rounded), label: Text('Logs')),
              NavigationRailDestination(
                  icon: Icon(Icons.auto_graph_rounded),
                  label: Text('Statistics'))
            ],
          ),
          page
        ],
      ),
    );
  }
}
