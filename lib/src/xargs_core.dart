import 'dart:convert';

RegExp _regExp = RegExp('^(-{1,2})(.+)\$');

class XArgs {
  List<_XArg> _args = [];

  XArgs._();

  XArgs.of(List<String> argArray) {
    _args.clear();
    for (var value in argArray) {
      if (_regExp.hasMatch(value)) break;
      _args.add(_XArg.ofSingleValue(value));
    }

    _XArg target;
    for (var value in argArray) {
      if (_regExp.hasMatch(value)) {
        target = _XArg._();
        target.key = (_regExp.allMatches(value).toList()[0]).group(2);
        _args.add(target);
      } else {
        target?.values?.add(value);
      }
    }
  }

  bool hasKey(String key) => _args.any((arg) => arg.key == key);

  List<String> values(String key) {
    var found = _args.where((arg) => arg.key == key);
    return found.isNotEmpty ? found.first.values : [];
  }

  List<String> valuesNoKey() {
    return _args.where((arg) => arg.key.isEmpty).map((arg) => arg.values.single).toList();
  }

  String valueNoKeyAt(int index) {
    var values = valuesNoKey();
    return values.isEmpty || index > values.length ? null : values[index];
  }

  String firstValue(String key) {
    var found = values(key);
    return found.isNotEmpty ? found.first : null;
  }

  String operator [](String key) {
    return firstValue(key);
  }

  @override
  String toString() {
    return jsonEncode(_args.map((o) => o.isSingleValue ? o.values.single : {'key': o.key, 'values': o.values}).toList());
  }
}

class _XArg {
  String key;
  List<String> values = [];
  bool get isSingleValue => values.isNotEmpty && key.isEmpty && values.length == 1;

  _XArg._();

  _XArg.ofKeyValues(List<String> elements) {
    key = _regExp.allMatches(elements[0]).toList()[0].group(2);
    values = elements.skip(1).toList();
  }

  _XArg.ofSingleValue(String value) {
    key = '';
    values.add(value);
  }

  @override
  String toString() {
    return 'Arg{key: $key, values: $values}';
  }
}
