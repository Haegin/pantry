import 'package:pantry/Timer.dart';
import 'package:flutter/material.dart';

class TimerCard extends StatefulWidget {
  TimerCard({this.timer, this.remove});

  final Timer timer;
  final Function remove;

  @override
  _TimerCardState createState() => _TimerCardState();
}

class _TimerCardState extends State<TimerCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(widget.timer.expired() ? Icons.stop : Icons.timer),
      title: Text(widget.timer.name),
      subtitle: Text(
        widget.timer.expired()
            ? widget.timer.deadline()
            : widget.timer.remaining(),
      ),
      onLongPress: () {
        widget.remove();
      },
    ));
  }
}
