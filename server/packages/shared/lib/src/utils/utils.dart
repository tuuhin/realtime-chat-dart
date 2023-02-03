import 'dart:math';

String get _getRandomChr => String.fromCharCode(65 + Random().nextInt(26));

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
