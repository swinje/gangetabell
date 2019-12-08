import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'gangetabell.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
          title: "Gangetabell",
          styleTitle: TextStyle(
              color: Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono'),
          description: "Få ti rette på rad!\nHva er ditt nivå?",
          styleDescription: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
              fontFamily: 'Raleway'),
          pathImage: "assets/math.png",
          colorBegin: Colors.blueAccent,
          colorEnd: Colors.blueGrey,
          directionColorBegin: Alignment.topCenter,
          directionColorEnd: Alignment.bottomCenter,
          maxLineTextDescription: 3),
    );
  }

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Gangetabell()),
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
        slides: this.slides,
        renderDoneBtn: this.renderDoneBtn(),
        isShowDotIndicator: false,
        sizeDot: 0.0,
        onDonePress: this.onDonePress,
        colorDoneBtn: Colors.blue,
        highlightColorDoneBtn: Colors.grey);
  }
}
