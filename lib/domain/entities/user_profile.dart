import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.firebaseUid,
    required this.email,
    this.customName,
    this.photoUrl,
    this.languageCode = 'tr',
    this.isDarkMode = false,
  });

  final String firebaseUid;
  final String email;
  final String? customName;
  final String? photoUrl;
  final String languageCode;
  final bool isDarkMode;

  UserProfile copyWith({
    String? customName,
    String? photoUrl,
    String? languageCode,
    bool? isDarkMode,
  }) =>
      UserProfile(
        firebaseUid: firebaseUid,
        email: email,
        customName: customName ?? this.customName,
        photoUrl: photoUrl ?? this.photoUrl,
        languageCode: languageCode ?? this.languageCode,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  @override
  List<Object?> get props =>
      [firebaseUid, email, customName, photoUrl, languageCode, isDarkMode];
}
