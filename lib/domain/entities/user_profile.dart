import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.firebaseUid,
    required this.email,
    this.customName,
    this.photoUrl,
    this.languageCode = 'tr',
    this.themeMode = 'light',
  });

  final String firebaseUid;
  final String email;
  final String? customName;
  final String? photoUrl;
  final String languageCode;
  final String themeMode;

  UserProfile copyWith({
    String? customName,
    String? photoUrl,
    String? languageCode,
    String? themeMode,
  }) =>
      UserProfile(
        firebaseUid: firebaseUid,
        email: email,
        customName: customName ?? this.customName,
        photoUrl: photoUrl ?? this.photoUrl,
        languageCode: languageCode ?? this.languageCode,
        themeMode: themeMode ?? this.themeMode,
      );

  @override
  List<Object?> get props =>
      [firebaseUid, email, customName, photoUrl, languageCode, themeMode];
}
