import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class timer extends StatefulWidget {
  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<timer> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = false;
  int timeRemaining = 0;
  int totalTime = 1;
  String timeToDisplay = "";
  bool checkTimer = true;
  void startIsClicked(){
    timeRemaining = (hour*3600) + (min*60) +sec;
    totalTime = timeRemaining;
    Timer.periodic(Duration(
      seconds: 1,
    ), (Timer t){
      setState(() {
        if(timeRemaining < 1 || checkTimer == false){
          t.cancel();
          checkTimer = true;
        }
        else{
          timeRemaining = timeRemaining - 1;
          if(timeRemaining == 0){
            playTone();

          }
        }
        timeToDisplay = (timeRemaining~/3600).toString().padLeft(2, '0') + ":" + ((timeRemaining%3600)~/60).toString().padLeft(2, '0') + ":" + (timeRemaining%60).toString().padLeft(2, '0');
        started = true;
      });
    });

  }
  void playTone(){
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1.0, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );


  }
  void stopIsClicked(){
    setState(() {
      checkTimer =false;
      started = false;
    });

  }
  void resetIsClicked(){
    setState(() {
      started = false;
      timeRemaining = 0;
      timeToDisplay = "00:00:00";
      FlutterRingtonePlayer.stop();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0,),
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Hours"),
                    NumberPicker.integer(
                        initialValue: hour,
                        maxValue: 23,
                        minValue: 0,
                        onChanged: (val){
                          setState(() {
                            hour = val;
                            totalTime = hour*3600 + min*60 +sec;
                          });
                        }
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Minutes"),
                    NumberPicker.integer(
                        initialValue: min,
                        maxValue: 59,
                        minValue: 0,
                        onChanged: (val){
                          setState(() {
                            min = val;
                            totalTime = hour*3600 + min*60 +sec;
                          });
                        }
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Second"),
                    NumberPicker.integer(
                        initialValue: sec,
                        maxValue: 59,
                        minValue: 0,
                        onChanged: (val){
                          setState(() {
                            sec = val;
                            totalTime = hour*3600 + min*60 +sec;
                          });
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(progressBarWidth: 10.0),
                angleRange: 360,
                startAngle: 270,
              ),
              min: 0,
              max: 100,
              initialValue: totalTime == 0?0:timeRemaining*100/totalTime,



            ),
          ),
          Text(
            timeToDisplay,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          started?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.redAccent,
                  onPressed: started ? stopIsClicked : null,
                  child: Text("Stop",style: TextStyle(color: Colors.black),),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Colors.greenAccent,
                  onPressed: started ? resetIsClicked : null,
                  child: Text("Reset",style: TextStyle(color: Colors.black),),
                ),
              )
            ],
          ):Expanded(
            flex: 1,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: totalTime==1?Colors.redAccent:Colors.greenAccent,
              onPressed: started ? null : startIsClicked,
              child: Text("Start",style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }
}