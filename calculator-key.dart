import 'package:flutter/material.dart';
import 'key-controller.dart';
import 'key-symbol.dart';

abstract class Keys {
  static KeySymbol clear = const KeySymbol('C');
  static KeySymbol next = const KeySymbol('>');
  static KeySymbol equals = const KeySymbol('=');

  static KeySymbol zero = const KeySymbol('0');
  static KeySymbol one = const KeySymbol('1');
  static KeySymbol two = const KeySymbol('2');
  static KeySymbol three = const KeySymbol('3');
  static KeySymbol four = const KeySymbol('4');
  static KeySymbol five = const KeySymbol('5');
  static KeySymbol six = const KeySymbol('6');
  static KeySymbol seven = const KeySymbol('7');
  static KeySymbol eight = const KeySymbol('8');
  static KeySymbol nine = const KeySymbol('9');
}

class CalculatorKey extends StatelessWidget {
  CalculatorKey({this.symbol});

  final KeySymbol symbol;

  Color get color {
    switch (symbol.type) {
      case KeyType.ACTION:
        return Color.fromARGB(255, 96, 96, 96);

      case KeyType.INTEGER:
      default:
        return Color.fromARGB(255, 128, 128, 128);
    }
  }

  static dynamic _fire(CalculatorKey key) => KeyController.fire(KeyEvent(key));

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 6 + 20;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: size,
      padding: EdgeInsets.all(2),
      height: size,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: color,
        elevation: 4,
        child: Text(symbol.value, style: TextStyle(
          fontSize: width * 0.10,
          color: Colors.white, fontFamily: 'Raleway'
        )),
        onPressed: () => _fire(this),
      ),
    );
  }
}
