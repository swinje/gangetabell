import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  Question({Key key, this.value, this.height, this.color}) : super(key: key);

  final String value;
  final double height;
  final int color;

  String get _output => value == null ? "" : value.toString();
  double get _margin => 10;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
        padding: EdgeInsets.all(_margin),
        constraints: BoxConstraints.expand(height: height),
        child: Container(
            constraints: BoxConstraints.expand(height: height - (_margin)),
            decoration: BoxDecoration(
                gradient: color == 0 ? null : getGradient(color),
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

  LinearGradient getGradient(int _color) {
    switch (_color) {
      case 1:
        return LinearGradient(colors: [Colors.green[400], Colors.green[900]]);
        break;
      case 2:
        return LinearGradient(colors: [Colors.redAccent, Colors.red]);
        break;
      default:
        break;
    }
    return LinearGradient(colors: [Colors.grey, Colors.blueGrey]);
  }
}
