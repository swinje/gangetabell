import 'dart:async';
import 'calculator-key.dart';
import 'key-controller.dart';
import 'key-symbol.dart';
import 'question-controller.dart';
import 'multiplier.dart';

const correctColor = 1, wrongColor = 2;

abstract class Processor {
  static String _value = '0';

  static var _multiplier = Multiplier();

  static StreamController _controller = StreamController();
  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(Function handler) => _stream.listen(handler);
  static void refresh() => _fire(_output);

  static void _fire(String data) => _controller.add(_output);

  static String get _output => _value;

  static dispose() => _controller.close();

  static process(dynamic event) {
    CalculatorKey key = (event as KeyEvent).key;
    switch (key.symbol.type) {
      case KeyType.ACTION:
        return handleAction(key);

      case KeyType.INTEGER:
        return handleInteger(key);
    }
  }

  static void handleAction(CalculatorKey key) {
    Map<KeySymbol, dynamic> table = {
      Keys.clear: () => _clear(),
      Keys.equals: () => _checkValue(),
      Keys.next: () => nextExpression(),
    };

    table[key.symbol]();
    refresh();
  }

  static void handleInteger(CalculatorKey key) {
    String val = key.symbol.value;
    _value = (_value == '0') ? val : _value + val;
    refresh();
  }

  static void _clear() {
    _value = '0';
    refresh();
  }

  static void setMasterLevel(int _masterLevel) {
    _multiplier.setMasterLevel(_masterLevel);
  }

  static int get masterLevel => _multiplier.masterLevel;

  static void _checkValue() {
    if(_multiplier.zeroValue(_value))
      return;
    if (_multiplier.checkCorrect(_value)) {
      QuestionController.add(QuestionEvent(_multiplier.getExpression(), correctColor));
      nextExpression();
    } else {
      QuestionController.add(QuestionEvent(_multiplier.getExpression(), wrongColor));
      _clear();
    }
  }

  static void nextExpression() {
    _clear();
    QuestionController.add(QuestionEvent(_multiplier.makeExpression(), 0));
  }

}
