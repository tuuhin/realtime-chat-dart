import 'dart:math';

///Gets an random value from a to z
String get _getRandomChr => String.fromCharCode(65 + Random().nextInt(26));

///Creates arandom value keeping the fact there is no similar values in the list
String createRoomId(List<String> prev) {
  final code = '$_getRandomChr$_getRandomChr$_getRandomChr$_getRandomChr';

  while (true) {
    if (!prev.contains(code)) {
      break;
    }
    createRoomId(prev);
  }
  return code;
}
