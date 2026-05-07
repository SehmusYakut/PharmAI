import 'package:flutter/foundation.dart';

class AuthStateNotifier extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void update(bool authenticated) {
    if (_isAuthenticated != authenticated) {
      _isAuthenticated = authenticated;
      notifyListeners();
    }
  }
}
