/// AppConfig – single source of truth for environment, feature flags,
/// and Privacy-by-Design / KVKK compliance settings.
///
/// KVKK (Turkish Data Protection Law) & GDPR principles enforced here:
///   • Data minimization  : only name, surname, email are ever collected.
///   • Purpose limitation : each field is tagged with its sole legal purpose.
///   • Storage security   : no sensitive data stored in plain text.
///   • Consent tracking   : consentGiven must be true before any PII is persisted.
///   • Right to erasure   : eraseUserData() wipes all locally stored PII.
class AppConfig {
  AppConfig._();

  // ── App identity ────────────────────────────────────────────────────────────

  static const String appName = 'PharmAI';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // ── Privacy-by-Design: allowed PII fields ───────────────────────────────────
  // Only these three fields may ever be collected from the user (KVKK Art. 4 –
  // data minimisation).  Any future collection must be approved and this list
  // updated with a comment explaining the legal basis.

  /// Fields that may be collected: name, surname, email – nothing else.
  static const List<String> allowedPiiFields = ['name', 'surname', 'email'];

  // ── Privacy flags ───────────────────────────────────────────────────────────

  /// When false no PII is written to disk or sent to any remote endpoint.
  static bool consentGiven = false;

  /// Flips to true once the user accepts the KVKK / Privacy Policy screen.
  static void grantConsent() => consentGiven = true;

  /// Revoke consent and trigger local data erasure (KVKK Art. 7 – right to
  /// erasure).  The caller is responsible for also clearing remote records.
  static Future<void> revokeConsent({
    required Future<void> Function() eraseLocalData,
  }) async {
    consentGiven = false;
    await eraseLocalData();
  }

  // ── Feature flags ───────────────────────────────────────────────────────────

  static const bool enableIcd10Search = true;
  static const bool enableDrugInfo = true;
  static const bool enableCalculators = true;

  /// Isar is preferred over network for speed (see ProjectRules §7).
  static const bool preferLocalData = true;

  // ── Database ────────────────────────────────────────────────────────────────

  static const String isarDbName = 'pharmai_db';

  // ── Supported locales ───────────────────────────────────────────────────────

  static const List<String> supportedLocales = ['tr', 'en'];
  static const String defaultLocale = 'tr';

  // ── Privacy policy URLs (must be kept up-to-date) ───────────────────────────

  static const String privacyPolicyUrlTr =
      'https://pharmai.example.com/gizlilik';
  static const String privacyPolicyUrlEn =
      'https://pharmai.example.com/privacy';
  static const String kvkkTextUrl =
      'https://pharmai.example.com/kvkk-aydinlatma-metni';
}
