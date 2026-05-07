import 'package:isar/isar.dart';
import 'package:pharmai/domain/entities/user_profile.dart';

part 'local_profile_model.g.dart';

@collection
class LocalProfileModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.hash, unique: true)
  late String firebaseUid;

  late String email;
  String? customName;
  String? photoUrl;
  String languageCode = 'tr';
  bool isDarkMode = false;

  UserProfile toDomain() => UserProfile(
        firebaseUid: firebaseUid,
        email: email,
        customName: customName,
        photoUrl: photoUrl,
        languageCode: languageCode,
        isDarkMode: isDarkMode,
      );

  static LocalProfileModel fromDomain(UserProfile p) => LocalProfileModel()
    ..firebaseUid = p.firebaseUid
    ..email = p.email
    ..customName = p.customName
    ..photoUrl = p.photoUrl
    ..languageCode = p.languageCode
    ..isDarkMode = p.isDarkMode;
}
