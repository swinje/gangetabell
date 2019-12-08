import 'dart:collection';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class Multiplier {
  int leftSide, rightSide, result, masterLevel = 0;
  var rng, last10 = ListQueue(10);
  String expression;

  Multiplier() {
    _read();
    rng = new Random();
  }

  addCheck() {
    // Has potential to run forever, but not so likely
    bool _found = true;
    while (_found) {
      leftSide = rng.nextInt(8) + masterLevel + 1;
      rightSide = rng.nextInt(8) + masterLevel + 1;
      result = leftSide * rightSide;
      if (!last10.contains(result)) {
        _found = false;
        last10.add(result);
      }
      if (last10.length > 10) last10.removeFirst();
    }
  }

  void setMasterLevel(int _masterLevel) async {
    masterLevel = _masterLevel;
    await _save();
  }

  String makeExpression() {
    addCheck();
    expression = leftSide.toString() + 'X' + rightSide.toString();
    return expression;
  }

  String getExpression() {
    return expression;
  }

  bool zeroValue(String inputValue) {
    int iVal = int.parse(inputValue);
    if (iVal == 0) {
      return true;
    }
    return false;
  }

  bool checkCorrect(String inputValue) {
    int iVal = int.parse(inputValue);
    if (iVal == result) {
      return true;
    }
    return false;
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'master_level';
    masterLevel = prefs.getInt(key) ?? 0;
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'master_level';
    prefs.setInt(key, masterLevel);
  }
}
