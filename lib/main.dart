import 'package:flutter/material.dart';

import 'package:pantry/models/Timer.dart';
import 'package:pantry/screens/timerCard.dart';

void main() => runApp(Pantry());

class Pantry extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantry',
      theme: ThemeData(
        primarySwatch: Colors.orange,
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
          return TimerCard(timer: timer, remove: () => _remove(index));
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
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.local_drink), title: Text("Ferments")),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt), title: Text("Recipes"))
      ]),
    );
  }
}
