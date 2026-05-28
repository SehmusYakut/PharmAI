import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_device/safe_device.dart';

class SecurityService {
  SecurityService() : _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  final FlutterSecureStorage _storage;

  static const String _isarKeyName = 'isar_encryption_key';
  static const String _premiumSignatureKeyName = 'premium_sig_key';
  static const String _geminiKeyName = 'gemini_api_key';

  /// Generates or retrieves a hardware-backed 64-byte key for Isar encryption.
  /// Uses compute to offload RNG from the main thread.
  Future<Uint8List> getIsarEncryptionKey() async {
    final existing = await _storage.read(key: _isarKeyName);
    if (existing != null) {
      return base64Decode(existing);
    }

    final key = await compute((_) {
      final random = Random.secure();
      return Uint8List.fromList(
        List.generate(64, (_) => random.nextInt(256)),
      );
    }, null);

    await _storage.write(key: _isarKeyName, value: base64Encode(key));
    return key;
  }

  /// Retrieves or generates a key for HMAC-SHA256 signing of local state.
  Future<List<int>> getPremiumSignatureKey() async {
    final existing = await _storage.read(key: _premiumSignatureKeyName);
    if (existing != null) {
      return base64Decode(existing);
    }

    final random = Random.secure();
    final key = List.generate(32, (_) => random.nextInt(256));
    await _storage.write(key: _premiumSignatureKeyName, value: base64Encode(key));
    return key;
  }

  /// Securely stores the Gemini API key.
  Future<void> saveGeminiApiKey(String apiKey) async {
    await _storage.write(key: _geminiKeyName, value: apiKey);
  }

  /// Retrieves the Gemini API key from secure storage.
  Future<String?> getGeminiApiKey() async {
    return _storage.read(key: _geminiKeyName);
  }

  /// Performs a lightweight RASP check (Root/Jailbreak).
  /// Returns true if the device is likely compromised.
  Future<bool> isDeviceCompromised() async {
    try {
      // SafeDevice checks are asynchronous and non-blocking.
      final isJailBroken = await SafeDevice.isJailBroken;
      
      // We prioritize Root/Jailbreak detection. 
      // Emulators are allowed for development/testing but flagged if needed.
      return isJailBroken;
    } catch (_) {
      return false; // Default to safe if check fails
    }
  }

  /// Calculates HMAC-SHA256 signature for a given payload.
  Future<String> calculateSignature(String payload) async {
    final key = await getPremiumSignatureKey();
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(utf8.encode(payload));
    return digest.toString();
  }
}
