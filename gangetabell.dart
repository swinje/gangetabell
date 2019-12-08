import 'package:flutter/material.dart';
import 'key-controller.dart';
import 'processor.dart';
import 'question-controller.dart';
import 'progress-painter.dart';
import 'question.dart';
import 'display.dart';
import 'key-pad.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';

const correctColor = 1, wrongColor = 2;

Timer timer;
int correct = 0, remainingTime = 10;

const bellAudioPath = "bell.mp3";
const applauseAudioPath = "applause.mp3";

class Gangetabell extends StatefulWidget {
  Gangetabell({Key key}) : super(key: key);

  @override
  _GangetabellState createState() => _GangetabellState();
}

class _GangetabellState extends State<Gangetabell> {
  String _output, _input;
  int _color;
  static AudioCache _player = new AudioCache();

  @override
  void initState() {
    KeyController.listen((event) => Processor.process(event));
    Processor.listen((data) => setState(() {
          _output = data;
        }));
    Processor.refresh();

    QuestionController.listen((data) => setState(() {
          _input = data.question;
          _color = data.color;
          levelCheck();
          startTimer();
        }));

    Processor.nextExpression();
    startTimer();

    super.initState();
  }

  void levelCheck() async {
    if (_color == correctColor && remainingTime >= 0) {
      correct++;

      if (correct % 10 == 0) {
        Processor.setMasterLevel(Processor.masterLevel + 1);
        _player.play(applauseAudioPath);
      } else if (correct % 5 == 0) _player.play(bellAudioPath);
    } else if (_color == wrongColor || remainingTime < 0) {
      correct = 0;
      timer.cancel();
    }
  }

  void startTimer() {
    remainingTime = 10;
    if (timer != null) timer.cancel();
    timer = new Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => setState(
            () => (remainingTime < -10) ? timer.cancel() : remainingTime--));
  }

  @override
  void dispose() {
    timer.cancel();
    KeyController.dispose();
    Processor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    double displayHeight = screen.height / 8;
    double displayWidth = screen.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(196, 32, 64, 96),
      appBar: AppBar(
        title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(children: <Widget>[
              Image(
                  image: AssetImage('assets/question.jpg'),
                  height: 80,
                  width: 80),
              Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text('Gangetabellen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Raleway')))
            ])),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              Processor.setMasterLevel(
                  Processor.masterLevel > 0 ? Processor.masterLevel - 1 : 0);
              setState(() {});
            },
          )
        ],
      ),
      body: Stack(children: <Widget>[
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              levelInfo(),
              Stack(children: <Widget>[
                Question(value: _input, height: displayHeight, color: _color),
                progressInfo(displayHeight),
              ]),
              Display(value: _output, height: displayHeight),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: displayWidth / 6, vertical: 0.0),
                  child: KeyPad())
            ]),
      ]),
    );
  }

  Widget levelInfo() {
    double width = MediaQuery.of(context).size.width;

    return Row(children: <Widget>[
      Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Nivå: ' + Processor.masterLevel.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: width * 0.06,
                color: Colors.white,
              ))),
      Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: CustomPaint(
            foregroundPainter: ProgressPainter(
                value: remainingTime >= 0 ? remainingTime / 10 : 0.0),
          ),
        ),
      ),
      Padding(
          padding: EdgeInsets.all(10.0),
          child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 1000),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColor(_color),
                ),
              )))
    ]);
  }

  Color getColor(int _checkColor) {
    if (remainingTime <= 0) return Colors.yellow;
    switch (_checkColor) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  Widget progressInfo(double height) {
    return Opacity(
        child: Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints.expand(
                height: height,
                width: correct % 10 / 10 * MediaQuery.of(context).size.width),
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                constraints: BoxConstraints.expand(height: height - (10)),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(10.0))))),
        opacity: 0.5);
  }
}
