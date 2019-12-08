import 'calculator-key.dart';

enum KeyType { ACTION, INTEGER }

class KeySymbol {
  const KeySymbol(this.value);
  final String value;

  static List<KeySymbol> _actions = [Keys.clear, Keys.next, Keys.equals];

  @override
  String toString() => value;

  bool get isAction => _actions.contains(this);
  bool get isInteger => !isAction;

  KeyType get type => isAction ? KeyType.ACTION : KeyType.INTEGER;
}
