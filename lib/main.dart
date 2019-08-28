import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiver/async.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.white,
        ),
        home: MainUI());
  }
}

class MainUI extends StatefulWidget {
  @override
  _MainUIState createState() {
    return _MainUIState();
  }
}

class _MainUIState extends State {
  Color a1 = Colors.red;
  Color a2 = Colors.blue;
  Color a3 = Colors.green;
  Color a4 = Colors.white;
  Color a5 = Colors.yellow;
  Color a6 = Colors.black;
  Color a7 = Colors.pink;

  List all_colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.white,
    Colors.yellow,
    Colors.black,
    Colors.pink,
  ];
  var score = 7;
  var t = Icons.pause;

  int _start = 45;
  int _current = 45;

  _gameWin() {
    Alert(
      context: context,
      type: AlertType.success,
      title: "You Won!",
      desc: "Winner Winner Chicken Dinner!",
      buttons: [
        DialogButton(
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => exit(0),
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "Try again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              t = Icons.pause;
              startTimer();
            });
            Navigator.pop(context);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  _gamePause() {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Game Paused!",
      buttons: [
        DialogButton(
          child: Text(
            "Exit",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => exit(0),
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "Try again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              t = Icons.pause;
              startTimer();
            });
            Navigator.pop(context);
          },
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      t = Icons.play_arrow;
      a1 = all_colors[Random.secure().nextInt(all_colors.length)];
      a2 = all_colors[Random.secure().nextInt(all_colors.length)];
      a3 = all_colors[Random.secure().nextInt(all_colors.length)];
      a4 = all_colors[Random.secure().nextInt(all_colors.length)];
      a5 = all_colors[Random.secure().nextInt(all_colors.length)];
      a6 = all_colors[Random.secure().nextInt(all_colors.length)];
      a7 = all_colors[Random.secure().nextInt(all_colors.length)];
      Alert(
        context: context,
        type: AlertType.error,
        title: "Time's up",
        desc: "Game Over, Man. Game over!",
        buttons: [
          DialogButton(
            child: Text(
              "Exit",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => exit(0),
            color: Colors.red,
          ),
          DialogButton(
            child: Text(
              "Try again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                t = Icons.pause;
                startTimer();
              });
              Navigator.pop(context);
            },
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
          )
        ],
      ).show();
      _start = 90;
      _current = 90;
    });
  }

  checkScore() {
    Set scoreData = {a1, a2, a3, a4, a5, a6, a7};
    if (scoreData.length == 1) {
      score = scoreData.length - 1;
      _gameWin();
    } else {
      setState(() {
        score = scoreData.length;
      });
    }
  }

  _onAlertButtonPressed() {
    Alert(
      context: context,
      title: "Match It !!",
      desc: "To win , Match all tiles to a color",
      buttons: [
        DialogButton(
          child: Text(
            "START",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              t = Icons.pause;
              startTimer();
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      _onAlertButtonPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("TIme Left : $_current"),
                ),
                Container(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          t = Icons.pause;
                          _gamePause();
                        });
                      },
                      child: Icon(
                        t,
                        color: Colors.green,
                        size: 50,
                      )),
                ),
                Container(
                  child: Text("Tiles Left : $score"),
                ),
//                  Container(
//                    child: Icon(
//                      Icons.stop,
//                      color: Colors.red,
//                      size: 50,
//                    ),
//                  )
              ]),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a1 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                height: 100.0,
                width: 100.0,
                color: a1,
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a2 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                height: 100.0,
                width: 100.0,
                color: a2,
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a3 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  height: 100.0,
                  width: 100.0,
                  color: a3),
            ))
          ],
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            setState(() {
              a4 = all_colors[Random.secure().nextInt(all_colors.length)];
              checkScore();
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 700),
            height: 100.0,
            width: 100.0,
            color: a4,
          ),
        )),
        Row(
          children: <Widget>[
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a5 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                height: 100.0,
                width: 100.0,
                color: a5,
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a6 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 555),
                height: 100.0,
                width: 100.0,
                color: a6,
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () {
                setState(() {
                  a7 = all_colors[Random.secure().nextInt(all_colors.length)];
                  checkScore();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                height: 100.0,
                width: 100.0,
                color: a7,
              ),
            ))
          ],
        ),
      ],
    )));
  }
}

//
//Container(
//child: Padding(
//padding: const EdgeInsets.all(40.0),
//child: Column(
//children: <Widget>[
//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Container(
//child: Text('Today',
//style: TextStyle(
//color: Colors.black,
//fontWeight: FontWeight.bold,
//fontSize: 20)),
//),
//Container(
//decoration: BoxDecoration(
//borderRadius: BorderRadius.circular(20.0),
//color: Colors.blue),
//child: Icon(
//Icons.add,
//color: Colors.white,
//)),
//],
//),
//Row(children: <Widget>[
//Card(
//child: InkWell(
//splashColor: Colors.blue.withAlpha(30),
//onTap: () {
//print('Card tapped.');
//},
//child: Container(
//child: Text('A card that can be tapped'),
//height: 150,
//),
//),
//),
//])
//],
//),
//))
