import 'dart:io';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class alarm extends StatefulWidget {
  @override
  _alarmState createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  bool alarmValue = false;
  var time = DateTime.parse("2020-08-19 08:56:00Z");
  int zoneDifference = 19682;
  String alarmTime = "04:00";
  int  hour = 04;
  int min = 0;
  int result1 = 0;
  double result2 = 0;
  int result3 =0;

  void playTone(){
    FlutterRingtonePlayer.play(
      android: AndroidSounds.notification,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 1.0, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );


  }

  void alarmOn(){
    playTone();
  }
  int remainingTime=0;

  void setAlarm(){
    setState(() {
      time = DateTime.parse("${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString().padLeft(2, '0')}-${DateTime.now().toLocal().day.toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:00");
      remainingTime = (time.difference(DateTime.now().toLocal())).inSeconds.toInt();
      remainingTime<0?time =  DateTime.parse("${DateTime.now().toLocal().year.toString()}-${DateTime.now().toLocal().month.toString().padLeft(2, '0')}-${(DateTime.now().toLocal().day+1).toString().padLeft(2, '0')} ${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:00"):null;
      remainingTime = (time.difference(DateTime.now().toLocal())).inSeconds.toInt();
    });

  }
  void alarmOff(){
    setState(() {
      remainingTime =0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex:3,
            child: Text(
              "Alarm in ${(remainingTime/3600).toInt()} hours",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            flex:3,
            child: Text(
              " ${((remainingTime%3600)/60).toInt()} minutes",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                    child: Text(
                      hour.toString().padLeft(2, '0')+':'+min.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      result2 = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addAlarm(),)

                      );
                      print(result2);
                      result1 = result2.toInt();
                      result3 = result1<2?((result2 - result1)*100).toInt():((result2 - result1)*100).toInt()+1;
                      print(result1);
                      print(result3);
                      setState(() {
                        hour = result1;
                        min = result3;
                      });
                      setAlarm();
                    }
                ),
                Switch(
                  value: alarmValue,
                  onChanged: (bool newValue){
                    setState(() {
                      alarmValue = newValue;
                    });
                    alarmValue?setAlarm():alarmOff();


                    Timer s = Timer(Duration(seconds: remainingTime), alarmOn);
                    alarmValue?null:s.cancel();
                  },
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}

class addAlarm extends StatefulWidget {
  @override
  _addAlarmState createState() => _addAlarmState();
}

class _addAlarmState extends State<addAlarm> {
  bool isChecked = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thrusday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  int result1 =0;
  int result2 =0;
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0,),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Hour"),
                    NumberPicker.integer(
                      initialValue: result1,
                      maxValue: 23,
                      minValue: 0,
                      onChanged: (val){
                        setState(() {
                          result1 = val;
                        });

                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text("Minute"),
                    NumberPicker.integer(
                        initialValue: result2,
                        maxValue: 59,
                        minValue: 0,
                        onChanged: (val){
                          setState(() {
                            result2 = val;
                          });
                        }
                    ),
                  ],
                ),

              ],
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
            ),
            color: Colors.greenAccent,
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.black,),
            ),
            onPressed: (){
              Navigator.pop(context, (result1+result2/100));
            },
          ),
        ],
      ),
    );
  }
}