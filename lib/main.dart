import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'stopwatch_new.dart';
import 'timer.dart';
import 'alarm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Clock"),
              bottom: TabBar(
                tabs: <Widget>[
                  Icon(Icons.alarm_on),
                  Icon(Icons.av_timer),
                  Icon(Icons.timer),
                ],
                
              ),


            ),
            body: TabBarView(
              children: <Widget>[
                alarm(),
                timer(),
                stopwatch(),
              ],
            ),
          ),
        ),

    );
  }
}












