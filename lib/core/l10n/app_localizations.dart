import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Hand-crafted localizations for Turkish (default) and English.
///
/// No code generation required — add this delegate to [MaterialApp] and call
/// [AppLocalizations.of(context)] anywhere in the widget tree.
class AppLocalizations {
  const AppLocalizations(this.locale);
  final Locale locale;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('tr'), Locale('en')];

  bool get _isTr => locale.languageCode == 'tr';

  // ── App-level ──────────────────────────────────────────────────────────────
  String get appName => 'PharmAI';
  String get appTagline => _isTr
      ? 'Klinik Karar Destek Platformu'
      : 'Clinical Decision Support Platform';
  String get appVersion => 'v1.0.0';

  // ── Home page ──────────────────────────────────────────────────────────────
  String get features => _isTr ? 'Özellikler' : 'Features';

  String get navIcd10 => _isTr ? 'ICD-10 Arama' : 'ICD-10 Search';
  String get navDrugInfo => _isTr ? 'İlaç Bilgisi' : 'Drug Info';
  String get navCalculators => _isTr ? 'Hesaplayıcılar' : 'Calculators';

  String get icd10Subtitle =>
      _isTr ? 'Hızlı kod ve tanım araması' : 'Fast code and definition lookup';
  String get drugInfoSubtitle =>
      _isTr ? 'Güncel ilaç rehberi' : 'Current drug reference';
  String get calculatorsSubtitle =>
      _isTr ? 'BMI, GFH ve klinik skorlar' : 'BMI, GFR and clinical scores';

  String get badgeActive => _isTr ? 'AKTİF' : 'ACTIVE';
  String get badgeSoon => _isTr ? 'YAKINDA' : 'SOON';

  String get themeLightTooltip => _isTr ? 'Açık temaya geç' : 'Switch to light mode';
  String get themeDarkTooltip => _isTr ? 'Koyu temaya geç' : 'Switch to dark mode';

  // ── ICD-10 search page ─────────────────────────────────────────────────────
  String get icd10SearchTitle => _isTr ? 'ICD-10 Ara' : 'ICD-10 Search';
  String get searchPlaceholder => _isTr
      ? 'ICD-10 kodu veya tanım ara…'
      : 'Search ICD-10 code or description…';
  String get searchHint => _isTr
      ? 'ICD-10 kodu veya tanımını girin'
      : 'Enter an ICD-10 code or description';
  String get searchHintExample =>
      _isTr ? 'Örn: "E11", "diabetes", "J00"' : 'e.g. "E11", "diabetes", "J00"';
  String searchEmpty(String query) =>
      _isTr ? '"$query" için sonuç bulunamadı' : 'No results for "$query"';
  String get searchBack => _isTr ? 'Geri' : 'Back';
  String get searchClear => _isTr ? 'Temizle' : 'Clear';

  // ── Calculators ────────────────────────────────────────────────────────────
  String get calcTitle =>
      _isTr ? 'Klinik Hesaplayıcılar' : 'Clinical Calculators';
  String get calcCalculate => _isTr ? 'Hesapla' : 'Calculate';
  String get calcBmiTitle =>
      _isTr ? 'Vücut Kitle İndeksi (VKİ)' : 'Body Mass Index (BMI)';
  String get calcGfrTitle =>
      _isTr ? 'Glomerüler Filtrasyon Hızı (GFH)' : 'Glomerular Filtration Rate (GFR)';
  String get calcWeight => _isTr ? 'Ağırlık' : 'Weight';
  String get calcHeight => _isTr ? 'Boy' : 'Height';
  String get calcAge => _isTr ? 'Yaş' : 'Age';
  String get calcSerumCreatinine =>
      _isTr ? 'Serum Kreatinin' : 'Serum Creatinine';
  String get calcMale => _isTr ? 'Erkek' : 'Male';
  String get calcFemale => _isTr ? 'Kadın' : 'Female';

  // ── Auth & Profile ─────────────────────────────────────────────────────────
  String get signInWithGoogle =>
      _isTr ? 'Google ile Giriş Yap' : 'Sign in with Google';
  String get signOut => _isTr ? 'Çıkış Yap' : 'Sign Out';
  String get profile => _isTr ? 'Profil' : 'Profile';
  String get customName => _isTr ? 'Görünen Ad' : 'Display Name';
  String get darkMode => _isTr ? 'Koyu Tema' : 'Dark Mode';
  String get languageTurkish => _isTr ? 'Türkçe' : 'Turkish';
  String get bookmarks => _isTr ? 'Kaydedilenler' : 'Bookmarks';
  String get navProfile => _isTr ? 'Profil' : 'Profile';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['tr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
