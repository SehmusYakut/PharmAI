abstract class AppConstants {
  // ── Navigation route names ──────────────────────────────────────────────────
  static const String routeHome = '/';
  static const String routeIcd10Search = '/icd10';
  static const String routeDrugInfo = '/drugs';
  static const String routeCalculators = '/calculators';
  static const String routeCalcBmi = '/calculators/bmi';
  static const String routeCalcGfr = '/calculators/gfr';
  static const String routeCalcPediatric = '/calculators/pediatric';
  static const String routeCalcIvRate = '/calculators/iv-rate';
  static const String routePrivacyPolicy = '/privacy';
  static const String routeKvkk = '/kvkk';
  static const String routeLogin = '/login';
  static const String routeProfile = '/profile';

  // ── Isar collection names ───────────────────────────────────────────────────
  static const String collectionIcd10 = 'icd10_entries';
  static const String collectionDrugs = 'drug_entries';

  // ── Search ──────────────────────────────────────────────────────────────────
  static const int icd10SearchDebounceMs = 300;
  static const int minSearchLength = 2;
  static const int maxSearchResults = 50;

  // ── Calculator input limits ─────────────────────────────────────────────────
  static const double minWeightKg = 0.5;
  static const double maxWeightKg = 500.0;
  static const int minAgeYears = 0;
  static const int maxAgeYears = 130;
  static const double minHeightCm = 30.0;
  static const double maxHeightCm = 300.0;
  static const double minSerumCreatinine = 0.1;
  static const double maxSerumCreatinine = 30.0;
}
