import 'package:flutter/cupertino.dart';

class RoomJoinNotifier extends ChangeNotifier {
  bool _isJoinAllowed = false;

  bool get allowed => _isJoinAllowed;

  void allowJoin() {
    if (_isJoinAllowed) return;
    _isJoinAllowed = true;
    notifyListeners();
  }

  void reset() {
    if (!_isJoinAllowed) return;
    _isJoinAllowed = false;
    notifyListeners();
  }
}
