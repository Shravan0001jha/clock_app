import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class stopwatch extends StatefulWidget {
  @override
  _stopwatchState createState() => _stopwatchState();
}

class _stopwatchState extends State<stopwatch> {
  bool stopwatchActive = false;
  bool startIsPressed = false;
  String time = '00:00:00';
  String time1 = "";
  Stopwatch s = Stopwatch();
  Stopwatch l = Stopwatch();
  int k =0;
  final dur = const Duration(seconds: 1);
  void lapIsPressed(){
    setState(() {
      k = k+1;
      l.reset();
      l.start();
      startTimer();
    });
  }
  void startTimer(){
    Timer(dur, keepRunning);
  }
  void keepRunning(){
    if(s.isRunning || l.isRunning){
      startTimer();
    }
    setState(() {
      time = s.elapsed.inHours.toString().padLeft(2, '0') + ':' + (s.elapsed.inMinutes%60).toString().padLeft(2, '0') + ':' + (s.elapsed.inSeconds%60).toString().padLeft(2, '0');
      time1 = l.elapsed.inHours.toString().padLeft(2, '0') + ':' + (l.elapsed.inMinutes%60).toString().padLeft(2, '0') + ':' + (l.elapsed.inSeconds%60).toString().padLeft(2, '0');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: SizedBox(height: 70.0,),),
          Expanded(
            flex: 5,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),

          ),
          Expanded(
            flex: 2,
            child: k>0?Text("Lap 1          ${time1}"):SizedBox(),
          ),
          startIsPressed?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              stopwatchActive?FlatButton(
                child: Text(
                  "Stop",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: (){
                  s.stop();
                  l.stop();
                  setState(() {
                    stopwatchActive = false;
                  });
                },
              ):FlatButton(
                child: Text(
                  "Restart",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                color: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: (){
                  s.start();
                  l.start();
                  startTimer();
                  setState(() {
                    stopwatchActive = true;
                  });
                },
              ),
              stopwatchActive?FlatButton(
                child: Text(
                  "Lap",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.greenAccent,
                onPressed: (){
                  l.start();
                  lapIsPressed();

                },
              ):FlatButton(
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blueAccent,
                onPressed: (){
                  s.reset();
                  l.reset();
                  setState(() {
                    k=0;
                    startIsPressed = false;
                    stopwatchActive = false;
                    time = "00:00:00";
                  });
                },
              ),


            ],
          ):FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            color: Colors.greenAccent,
            child: Text(
              "Start",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: (){
              s.start();
              startTimer();
              setState(() {
                startIsPressed = true;
                stopwatchActive = true;
              });
            },
          ),
          SizedBox(height: 20.0,)



        ],
      ),

    );
  }
}