import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(Pantry());

class Pantry extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: PantryHome(title: 'Pantry'),
    );
  }
}

class PantryHome extends StatefulWidget {
  PantryHome({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PantryHomeState createState() => _PantryHomeState();
}

class _PantryHomeState extends State<PantryHome> {
  List<Timer> _timers = List();

  void _addTimer() {
    setState(() {
      _timers.add(Timer("Test Timer ${_timers.length + 1}",
          DateTime.now().add(Duration(minutes: 5))));
    });
  }

  void _remove(index) {
    setState(() {
      _timers.removeAt(index);
    });
  }

  Widget _buildList() {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: _timers.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        if (_timers.length > index) {
          final timer = _timers[index];
          return Card(
              child: ListTile(
            leading: Icon(timer.expired() ? Icons.stop : Icons.timer),
            title: Text(timer.name),
            subtitle: Text(
              timer.expired() ? timer.deadline() : timer.remaining(),
            ),
            onLongPress: () {
              _remove(index);
            },
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTimer,
        tooltip: 'Add Timer',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Timer {
  String name;
  DateTime when;

  Timer(this.name, this.when);

  bool expired() {
    return DateTime.now().isAfter(when);
  }

  String deadline() {
    final formatter = DateFormat("h:m a 'on' d MMM, y");
    return formatter.format(when);
  }

  String remaining() {
    final now = DateTime.now();
    final remaining = when.difference(now);
    return "${remaining.inHours}:" +
        "${remaining.inMinutes.remainder(Duration.minutesPerHour)}: " +
        "${remaining.inSeconds.remainder(Duration.secondsPerMinute)}";
  }
}
