import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesLocalDataSource {
  static const String _firstRunKey = 'is_first_run';
  static SharedPreferences? _cachedPrefs;

  Future<SharedPreferences?> _getPrefsSafely() async {
    if (_cachedPrefs != null) return _cachedPrefs;

    for (var attempt = 0; attempt < 3; attempt++) {
      try {
        _cachedPrefs = await SharedPreferences.getInstance();
        return _cachedPrefs;
      } on PlatformException catch (e) {
        final isChannelIssue =
            e.code == 'channel-error' ||
            (e.message?.contains('Unable to establish connection on channel') ??
                false);

        if (!isChannelIssue || attempt == 2) {
          debugPrint('SharedPreferences unavailable: ${e.code} ${e.message}');
          return null;
        }
        await Future<void>.delayed(const Duration(milliseconds: 120));
      } on MissingPluginException {
        debugPrint('SharedPreferences plugin is not registered yet.');
        return null;
      }
    }

    return null;
  }

  Future<bool> isFirstRun() async {
    final prefs = await _getPrefsSafely();
    if (prefs == null) return true;
    return prefs.getBool(_firstRunKey) ?? true;
  }

  Future<void> setFirstRun(bool value) async {
    final prefs = await _getPrefsSafely();
    if (prefs == null) return;
    await prefs.setBool(_firstRunKey, value);
  }
}
