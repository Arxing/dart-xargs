XArgs is a simple library to resolve command arguments

## Usage

A simple usage example:

```dart
import 'package:xargs/xargs.dart';

main() {
  String command = '1 2 3 4 -mode run --enable -who John Denis Peter';
  List<String> argArray = command.split(RegExp('\\s+'));
  XArgs xArgs = XArgs.of(argArray);
  print(xArgs); // ["1","2","3","4",{"key":"mode","values":["run"]},{"key":"enable","values":[]},{"key":"who","values":["John","Denis","Peter"]}]
  print(xArgs.valuesNoKey()); // [1, 2, 3, 4]
  print(xArgs.valueNoKeyAt(0)); // 1
  print(xArgs['mode']); // run
  print(xArgs.hasKey('enable')); // true
  print(xArgs['who']); // John
  print(xArgs.firstValue('who')); // John
  print(xArgs.values('who')); // [John, Denis, Peter]
}

```
