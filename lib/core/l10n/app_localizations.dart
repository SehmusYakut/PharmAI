import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Hand-crafted localizations for Turkish (default) and English.
///
/// No code generation required — add this delegate to [MaterialApp] and call
/// [AppLocalizations.of(context)] anywhere in the widget tree.
class AppLocalizations {
  String get drugBullet => _isTr ? '•' : '•';
  // ── Drug Details ─────────────────────────────────────────────────────────
  String get drugDetailsLabel => _isTr ? 'İlaç Detayları' : 'Drug Details';

  // ── ICD-10 Result Card Labels ───────────────────────────────────────────
  String get icd10LangEn => _isTr ? 'İngilizce Tanım' : 'English Description';
  String get icd10ChapterLabel => _isTr ? 'Bölüm' : 'Chapter';
  String get icd10BlockLabel => _isTr ? 'Blok' : 'Block';
  String get icd10WhoLabel => _isTr ? 'WHO Tanımı' : 'WHO Definition';
  // ── GFR Stages ───────────────────────────────────────────────────────────
  String get calcGfrStageG1 => _isTr ? 'G1' : 'G1';
  String get calcGfrStageG2 => _isTr ? 'G2' : 'G2';
  String get calcGfrStageG3a => _isTr ? 'G3a' : 'G3a';
  String get calcGfrStageG3b => _isTr ? 'G3b' : 'G3b';
  String get calcGfrStageG4 => _isTr ? 'G4' : 'G4';
  String get calcGfrStageG5 => _isTr ? 'G5' : 'G5';
  String get calcGfrStageDescG1 =>
      _isTr ? 'Normal veya yüksek' : 'Normal or high';
  String get calcGfrStageDescG2 => _isTr ? 'Hafif azalma' : 'Mildly decreased';
  String get calcGfrStageDescG3a =>
      _isTr ? 'Hafif-orta azalma' : 'Mild-moderate decrease';
  String get calcGfrStageDescG3b =>
      _isTr ? 'Orta-ciddi azalma' : 'Moderate-severe decrease';
  String get calcGfrStageDescG4 =>
      _isTr ? 'Ciddi azalma' : 'Severely decreased';
  String get calcGfrStageDescG5 =>
      _isTr ? 'Böbrek yetmezliği' : 'Kidney failure';
  // ── BMI Categories & Ranges ─────────────────────────────────────────────
  String get calcBmiAbbrev => _isTr ? 'VKİ' : 'BMI';
  String get calcBmiUnit => 'kg/m²';
  String get calcBmiCatSeverelyUnderweight =>
      _isTr ? 'Ciddi düşük ağırlık' : 'Severely underweight';
  String get calcBmiCatUnderweight => _isTr ? 'Düşük ağırlık' : 'Underweight';
  String get calcBmiCatNormal => _isTr ? 'Normal ağırlık' : 'Normal weight';
  String get calcBmiCatOverweight => _isTr ? 'Fazla kilolu' : 'Overweight';
  String get calcBmiCatObeseClassI =>
      _isTr ? 'Obezite - Sınıf I' : 'Obesity - Class I';
  String get calcBmiCatObeseClassII =>
      _isTr ? 'Obezite - Sınıf II' : 'Obesity - Class II';
  String get calcBmiCatObeseClassIII =>
      _isTr ? 'Obezite - Sınıf III' : 'Obesity - Class III';
  String get calcBmiRangeSeverelyUnderweight =>
      _isTr ? '< 16,0 kg/m²' : '< 16.0 kg/m²';
  String get calcBmiRangeUnderweight =>
      _isTr ? '16,0 - 18,4 kg/m²' : '16.0 - 18.4 kg/m²';
  String get calcBmiRangeNormal =>
      _isTr ? '18,5 - 24,9 kg/m²' : '18.5 - 24.9 kg/m²';
  String get calcBmiRangeOverweight =>
      _isTr ? '25,0 - 29,9 kg/m²' : '25.0 - 29.9 kg/m²';
  String get calcBmiRangeObeseClassI =>
      _isTr ? '30,0 - 34,9 kg/m²' : '30.0 - 34.9 kg/m²';
  String get calcBmiRangeObeseClassII =>
      _isTr ? '35,0 - 39,9 kg/m²' : '35.0 - 39.9 kg/m²';
  String get calcBmiRangeObeseClassIII =>
      _isTr ? '>= 40,0 kg/m²' : '>= 40.0 kg/m²';

  // ── GFR Labels ─────────────────────────────────────────────────────────--
  String get calcGfrCkdEpiLabel => _isTr ? 'CKD-EPI 2021' : 'CKD-EPI 2021';
  String get calcGfrCkdEpiNote =>
      _isTr ? 'Evreleme için tercih edilir' : 'Preferred for staging';
  String get calcGfrCkdEpiUnit => 'mL/min/1.73m²';
  String get calcGfrCockcroftLabel =>
      _isTr ? 'Cockcroft-Gault' : 'Cockcroft-Gault';
  String get calcGfrCockcroftNote =>
      _isTr ? 'İlaç dozlaması için tercih edilir' : 'Preferred for drug dosing';
  String get calcGfrCockcroftUnit => 'mL/min';
  // ── Chat Rename & Error ─────────────────────────────────────────────────--
  String get chatRenameAction => _isTr ? 'Yeniden Adlandır' : 'Rename';
  String get chatErrorLocalSave =>
      _isTr ? 'Yerel kaydetme hatası.' : 'Local save error.';
  String get chatErrorUpgrade =>
      _isTr ? 'Yükseltme başarısız.' : 'Upgrade failed.';
  String get chatErrorRename => _isTr
      ? 'Sohbet oturumu yeniden adlandırılamadı.'
      : 'Failed to rename chat session.';
  String get chatRenameTitle =>
      _isTr ? 'Sohbeti Yeniden Adlandır' : 'Rename Chat';
  String get chatRenameHint =>
      _isTr ? 'Yeni oturum adını girin' : 'Enter a new session name';
  String get chatRenameCancel => _isTr ? 'İptal' : 'Cancel';
  String get chatRenameSave => _isTr ? 'Kaydet' : 'Save';
  // ── Error & Routing ───────────────────────────────────────────────────────
  String get chatInvalidSession =>
      _isTr ? 'Geçersiz sohbet oturumu.' : 'Invalid chat session.';
  String routeNotFound(String uri) =>
      _isTr ? 'Sayfa bulunamadı: $uri' : 'Page not found: $uri';
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
  String get dashboardTitle => _isTr ? 'Klinik Panel' : 'Clinical Dashboard';
  String get dashboardWelcome => _isTr ? 'Hoş geldiniz.' : 'Welcome.';

  // ── Onboarding ─────────────────────────────────────────────────────────────
  String get onboardingTitle =>
      _isTr ? 'Hızlı Uygulama Turu' : 'Quick App Tour';
  String get onboardingSkip => _isTr ? 'Geç' : 'Skip';
  String get onboardingBack => _isTr ? 'Geri' : 'Back';
  String get onboardingNext => _isTr ? 'İleri' : 'Next';
  String get onboardingDone => _isTr ? 'Tamam' : 'Done';
  String get onboardingStepWelcomeTitle =>
      _isTr ? 'Klinik destek tek ekranda' : 'Clinical support in one place';
  String get onboardingStepWelcomeDescription => _isTr
      ? 'PharmAI, tanısal arama, ilaç bilgisi ve hesaplayıcıları hızlı bir akışta birleştirir.'
      : 'PharmAI combines diagnostic search, drug insights, and calculators in one fast workflow.';
  String get onboardingStepIcdTitle => _isTr ? 'ICD-10 Arama' : 'ICD-10 Search';
  String get onboardingStepIcdDescription => _isTr
      ? 'Kod veya tanım yazarak ilgili ICD-10 kayıtlarına saniyeler içinde ulaşın.'
      : 'Find ICD-10 entries in seconds by typing a code or diagnosis description.';
  String get onboardingStepDrugTitle =>
      _isTr ? 'İlaç Bilgisi' : 'Drug Information';
  String get onboardingStepDrugDescription => _isTr
      ? 'Etken madde, ATC kodu ve detaylı açıklamaları tek noktadan inceleyin.'
      : 'Review active ingredient, ATC code, and detailed medication notes from a single view.';
  String get onboardingStepCalcTitle =>
      _isTr ? 'Klinik Hesaplayıcılar' : 'Clinical Calculators';
  String get onboardingStepCalcDescription => _isTr
      ? 'BMI, GFH, pediatrik ağırlık ve IV damla hızı sonuçlarını kanıta dayalı formül bilgisi ile görün.'
      : 'Use BMI, GFR, pediatric weight, and IV drip tools with transparent evidence details.';

  // ── Home page ──────────────────────────────────────────────────────────────
  String get features => _isTr ? 'Özellikler' : 'Features';
  String get homeFeaturesSubtitle => _isTr
      ? 'Temel klinik araçlara hızlı erişim.'
      : 'Fast access to core clinical tools.';

  String get navIcd10 => _isTr ? 'ICD-10 Arama' : 'ICD-10 Search';
  String get navDrugInfo => _isTr ? 'İlaç Bilgisi' : 'Drug Info';
  String get navCalculators => _isTr ? 'Hesaplayıcılar' : 'Calculators';
  String get navChat => _isTr ? 'Klinik Sohbet' : 'Clinical Chat';

  String get icd10Subtitle =>
      _isTr ? 'Hızlı kod ve tanım araması' : 'Fast code and definition lookup';
  String get drugInfoSubtitle =>
      _isTr ? 'Güncel ilaç rehberi' : 'Current drug reference';
  String get calculatorsSubtitle =>
      _isTr ? 'BMI, GFH ve klinik skorlar' : 'BMI, GFR and clinical scores';
  String get chatSubtitle => _isTr
      ? 'Yapay zeka ile klinik sorular sorun'
      : 'Ask clinical questions with AI';

  String get badgeActive => _isTr ? 'AKTİF' : 'ACTIVE';
  String get badgeSoon => _isTr ? 'YAKINDA' : 'SOON';
  String get cardTapToOpen => _isTr ? 'Açmak için dokun' : 'Tap to open';

  String get themeLightTooltip =>
      _isTr ? 'Açık temaya geç' : 'Switch to light mode';
  String get themeDarkTooltip =>
      _isTr ? 'Koyu temaya geç' : 'Switch to dark mode';

  // ── Chat ─────────────────────────────────────────────────────────────────-
  String get chatDashboardTitle => _isTr ? 'Klinik Sohbet' : 'Clinical Chat';
  String get chatNewChat => _isTr ? 'Yeni sohbet' : 'New chat';
  String get chatNewSessionTitle => _isTr ? 'Yeni sohbet' : 'New chat';
  String get chatEmptyTitle =>
      _isTr ? 'Henüz sohbet yok' : 'No conversations yet';
  String get chatEmptySubtitle => _isTr
      ? 'Yeni bir klinik sohbet başlatarak geçmişinizi oluşturun.'
      : 'Start a new clinical chat to build your history.';
  String get chatInputHint =>
      _isTr ? 'Klinik bir soru yazın...' : 'Ask a clinical question...';
  String get chatTyping => _isTr ? 'Düşünüyor...' : 'Thinking...';
  String get chatLimitTitle =>
      _isTr ? 'Ücretsiz limit doldu' : 'Free tier limit reached';
  String get chatLimitBody => _isTr
      ? '3 ücretsiz soruyu kullandınız. Devam etmek için premiuma yükseltin.'
      : 'You have used your 3 free questions. Upgrade to premium to continue.';
  String get chatUpgradeSubtitle => _isTr
      ? 'Sınırsız klinik sohbet, öncelikli yanıtlar ve daha zengin bağlam.'
      : 'Unlimited clinical chat, priority responses, and richer context.';
  String get chatGoPremium => _isTr ? 'Premiuma Geç' : 'Go Premium';

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

  // ── Drug search page ───────────────────────────────────────────────────────
  String get drugSearchPlaceholder => _isTr
      ? 'İlaç adı, etken madde veya ATC kodu ara…'
      : 'Search drug name, ingredient, or ATC code…';
  String get drugSearchHint => _isTr
      ? 'İlaç adı veya etken madde girin'
      : 'Enter a drug name or active ingredient';
  String get drugSearchHintExample => _isTr
      ? 'Örn: "Aspirin", "Etodolak", "M01AB08"'
      : 'e.g. "Aspirin", "Etodolac", "M01AB08"';

  // ── Calculators ────────────────────────────────────────────────────────────
  String get calcBmiCitation => _isTr
      ? 'WHO Teknik Rapor Serisi 854 (1995)'
      : 'WHO Technical Report Series 854 (1995)';
  String get calcTitle =>
      _isTr ? 'Klinik Hesaplayıcılar' : 'Clinical Calculators';
  String get calcCalculate => _isTr ? 'Hesapla' : 'Calculate';
  String get calcInfoTooltip =>
      _isTr ? 'Formül ve kaynak bilgisi' : 'Formula and source';
  String get calcInfoTitle =>
      _isTr ? 'Kanıt ve Formül' : 'Evidence and Formula';
  String get calcFormulaLabel => _isTr ? 'Formül' : 'Formula';
  String get calcReferenceLabel => _isTr ? 'Referans' : 'Reference';
  String get calcBmiTitle =>
      _isTr ? 'Vücut Kitle İndeksi (VKİ)' : 'Body Mass Index (BMI)';
  String get calcBmiFormula => _isTr
      ? '• BMI = ağırlık(kg) / [boy(m)]^2'
      : '• BMI = weight(kg) / [height(m)]^2';
  String get calcBmiReference => _isTr
      ? 'WHO Technical Report Series 854 (1995)'
      : 'WHO Technical Report Series 854 (1995)';
  String get calcGfrTitle => _isTr
      ? 'Glomerüler Filtrasyon Hızı (GFH)'
      : 'Glomerular Filtration Rate (GFR)';
  String get calcGfrFormula => _isTr
      ? '• CKD-EPI 2021 Cockcroft-Gault (doz ayarı)'
      : '• CKD-EPI 2021 Cockcroft-Gault (dose adjustment)';
  String get calcGfrReference => _isTr
      ? 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022'
      : 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022';
  String get calcWeight => _isTr ? 'Ağırlık' : 'Weight';
  String get calcHeight => _isTr ? 'Boy' : 'Height';
  String get calcAge => _isTr ? 'Yaş' : 'Age';
  String get calcSerumCreatinine =>
      _isTr ? 'Serum Kreatinin' : 'Serum Creatinine';
  String get calcMale => _isTr ? 'Erkek' : 'Male';
  String get calcFemale => _isTr ? 'Kadın' : 'Female';
  String get calcPediatricWeightTitle => _isTr
      ? 'Pediatrik Tahmini Ağırlık (APLS)'
      : 'Pediatric Estimated Weight (APLS)';
  String get calcPediatricWeightFormula => _isTr
      ? '• 1-12 ay: (0.5 x ay) + 4\n• 1-5 yaş: (2 x yaş) + 8\n• 6-12 yaş: (3 x yaş) + 7'
      : '• 1-12 months: (0.5 x months) + 4\n• 1-5 years: (2 x age) + 8\n• 6-12 years: (3 x age) + 7';
  String get calcPediatricWeightReference =>
      _isTr ? 'Referans: APLS Kılavuzu' : 'Reference: APLS Guidelines';
  String get calcPediatricWeightCitation => _isTr
      ? 'Updated APLS formülleri (1-12 ay, 1-12 yaş)'
      : 'Updated APLS formulas (1-12 months, 1-12 years)';
  String get calcIvDripRateTitle => _isTr ? 'IV Damla Hızı' : 'IV Drip Rate';
  String get calcIvDripRateFormula => _isTr
      ? '• Damla/dk = [Hacim(mL) x Damla faktörü(gtt/mL)]\n / Süre(dk)'
      : '• Drops/min = [Volume(mL) x Drop factor(gtt/mL)]\n / Time(min)';
  String get calcIvDripRateReference => _isTr
      ? 'Referans: İnfüzyon Tedavi Standartları'
      : 'Reference: Infusion Therapy Standards';
  String get calcIvDripRateCitation => _isTr
      ? 'Damla/dk = (Hacim x Damla Faktörü) / Süre(dk)'
      : 'Drops/min = (Volume x Drop Factor) / Time(min)';
  String get calcAgeUnit => _isTr ? 'Yaş Birimi' : 'Age Unit';
  String get calcMonths => _isTr ? 'Ay' : 'Months';
  String get calcYears => _isTr ? 'Yıl' : 'Years';
  String get calcMonthsShort => _isTr ? 'ay' : 'mo';
  String get calcYearsShort => _isTr ? 'yıl' : 'yr';
  String get calcHours => _isTr ? 'Saat' : 'Hours';
  String get calcMinutes => _isTr ? 'Dakika' : 'Minutes';
  String get calcHoursShort => _isTr ? 'saat' : 'hr';
  String get calcMinutesShort => _isTr ? 'dk' : 'min';
  String get calcVolumeMl => _isTr ? 'Hacim (mL)' : 'Volume (mL)';
  String get calcDropFactor => _isTr ? 'Damla Faktörü' : 'Drop Factor';
  String get calcTotalTime => _isTr ? 'Toplam Süre' : 'Total Time';
  String get calcTimeUnit => _isTr ? 'Süre Birimi' : 'Time Unit';
  String get calcDropsPerMinute => _isTr ? 'Damla / dakika' : 'Drops / minute';
  String get calcDropsPerMinuteUnit => _isTr ? 'gtt/dk' : 'gtt/min';
  String get calcEstimatedWeight =>
      _isTr ? 'Tahmini Ağırlık' : 'Estimated Weight';
  String get calcKgUnit => 'kg';
  String get calcMlUnit => 'mL';
  String calcDropFactorOption(int value) => '$value gtt/mL';
  String get calcCmUnit => 'cm';
  String get calcMgDlUnit => 'mg/dL';
  String get calcGfrCitation => _isTr
      ? 'CKD-EPI 2021 · Inker ve ark., NEJM 385:1737 · Cockcroft-Gault, Nephron 1976 · KDIGO 2022'
      : 'CKD-EPI 2021 · Inker et al., NEJM 385:1737 · Cockcroft-Gault, Nephron 1976 · KDIGO 2022';

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
  bool isSupported(Locale locale) => ['tr', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
