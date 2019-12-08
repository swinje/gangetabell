import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  Display({Key key, this.value, this.height}) : super(key: key);

  final String value;
  final double height;

  String get _output => value.toString();
  double get _margin => 10;

  final LinearGradient _gradient =
      const LinearGradient(colors: [Colors.grey, Colors.blueGrey]);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: EdgeInsets.all(_margin),
        constraints: BoxConstraints.expand(height: height),
        child: Container(
            constraints: BoxConstraints.expand(height: height - (_margin)),
            decoration: BoxDecoration(
                gradient: _gradient,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius:
                    new BorderRadius.all(const Radius.circular(10.0))),
            child: Center(
                child: Text(
              _output,
              style: TextStyle(
                  fontSize: width * 0.12,
                  color: Colors.white,
                  fontFamily: 'Raleway'),
              textAlign: TextAlign.center,
            ))));
  }
}
