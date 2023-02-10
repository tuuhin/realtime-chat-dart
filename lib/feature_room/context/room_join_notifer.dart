import 'package:flutter/cupertino.dart';
import 'package:reatime_chat/main.dart';

class RoomJoinNotifier extends ChangeNotifier {
  bool _isJoinAllowed = false;

  bool get allowed => _isJoinAllowed;

  void allowJoin() {
    if (_isJoinAllowed) return;
    _isJoinAllowed = true;
    logger.fine("abcjabca");
    notifyListeners();
  }

  void dontAllowJoin() {
    if (!_isJoinAllowed) return;
    _isJoinAllowed = false;
    notifyListeners();
  }
}
