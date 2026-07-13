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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('tr'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('tr'), Locale('en'), Locale('de')];

  bool get _isTr => locale.languageCode == 'tr';
  bool get _isDe => locale.languageCode == 'de';

  // ── App-level ──────────────────────────────────────────────────────────────
  String get appName => 'PharmAI';
  String get appTagline => _isTr
      ? 'Klinik Karar Destek Platformu'
      : (_isDe
          ? 'Klinische Entscheidungsunterstützung'
          : 'Clinical Decision Support Platform');
  String get dashboardTitle =>
      _isTr ? 'Klinik Panel' : (_isDe ? 'Dashboard' : 'Clinical Dashboard');
  String get dashboardWelcome => _isTr
      ? 'Hoş geldiniz.'
      : (_isDe ? 'Willkommen.' : 'Welcome.');

  // ── Onboarding ─────────────────────────────────────────────────────────────
  String get onboardingTitle => _isTr
      ? 'Hızlı Uygulama Turu'
      : (_isDe ? 'App-Tour' : 'Quick App Tour');
  String get onboardingSkip =>
      _isTr ? 'Geç' : (_isDe ? 'Überspringen' : 'Skip');
  String get onboardingBack => _isTr ? 'Geri' : (_isDe ? 'Zurück' : 'Back');
  String get onboardingNext => _isTr ? 'İleri' : (_isDe ? 'Weiter' : 'Next');
  String get onboardingDone => _isTr ? 'Tamam' : (_isDe ? 'Fertig' : 'Done');
  String get onboardingStepWelcomeTitle => _isTr
      ? 'Klinik destek tek ekranda'
      : (_isDe
          ? 'Klinische Unterstützung'
          : 'Clinical support in one place');
  String get onboardingStepWelcomeDescription => _isTr
      ? 'PharmAI, tanısal arama, ilaç bilgisi ve hesaplayıcıları hızlı bir akışta birleştirir.'
      : (_isDe
          ? 'PharmAI kombiniert Suche, Medikamenteninfos und Rechner.'
          : 'PharmAI combines diagnostic search, drug insights, and calculators in one fast workflow.');
  String get onboardingStepIcdTitle =>
      _isTr ? 'ICD-10 Arama' : (_isDe ? 'ICD-10 Suche' : 'ICD-10 Search');
  String get onboardingStepIcdDescription => _isTr
      ? 'Kod veya tanım yazarak ilgili ICD-10 kayıtlarına saniyeler içinde ulaşın.'
      : (_isDe
          ? 'Finden Sie ICD-10-Einträge in Sekunden.'
          : 'Find ICD-10 entries in seconds by typing a code or diagnosis description.');
  String get onboardingStepDrugTitle => _isTr
      ? 'İlaç Bilgisi'
      : (_isDe ? 'Medikamenteninfo' : 'Drug Information');
  String get onboardingStepDrugDescription => _isTr
      ? 'Etken madde, ATC kodu ve detaylı açıklamaları tek noktadan inceleyin.'
      : (_isDe
          ? 'Wirkstoffe und ATC-Codes auf einen Blick.'
          : 'Review active ingredient, ATC code, and detailed medication notes from a single view.');
  String get onboardingStepCalcTitle => _isTr
      ? 'Klinik Hesaplayıcılar'
      : (_isDe ? 'Klinische Rechner' : 'Clinical Calculators');
  String get onboardingStepCalcDescription => _isTr
      ? 'BMI, GFH, pediatrik ağırlık ve IV damla hızı sonuçlarını kanıta dayalı formül bilgisi ile görün.'
      : (_isDe
          ? 'BMI, GFR und pädiatrische Rechner mit Evidenz.'
          : 'Use BMI, GFR, pediatric weight, and IV drip tools with transparent evidence details.');

  // ── Home page ──────────────────────────────────────────────────────────────
  String get features => _isTr ? 'Özellikler' : (_isDe ? 'Funktionen' : 'Features');
  String get homeFeaturesSubtitle => _isTr
      ? 'Temel klinik araçlara hızlı erişim.'
      : (_isDe
          ? 'Schneller Zugriff auf klinische Werkzeuge.'
          : 'Fast access to core clinical tools.');

  String get navIcd10 =>
      _isTr ? 'ICD-10 Arama' : (_isDe ? 'ICD-10 Suche' : 'ICD-10 Search');
  String get navDrugInfo =>
      _isTr ? 'İlaç Bilgisi' : (_isDe ? 'Medikamenteninfo' : 'Drug Info');
  String get navCalculators =>
      _isTr ? 'Hesaplayıcılar' : (_isDe ? 'Rechner' : 'Calculators');
  String get navChat =>
      _isTr ? 'Klinik Sohbet' : (_isDe ? 'Klinischer Chat' : 'Clinical Chat');

  String get icd10Subtitle => _isTr
      ? 'Hızlı kod ve tanım araması'
      : (_isDe ? 'Schnelle Code-Suche' : 'Fast code and definition lookup');
  String get drugInfoSubtitle => _isTr
      ? 'Güncel ilaç rehberi'
      : (_isDe ? 'Arzneimittelreferenz' : 'Current drug reference');
  String get calculatorsSubtitle => _isTr
      ? 'BMI, GFH ve klinik skorlar'
      : (_isDe ? 'BMI, GFR und Scores' : 'BMI, GFR and clinical scores');
  String get chatSubtitle => _isTr
      ? 'Yapay zeka ile klinik sorular sorun'
      : (_isDe ? 'Fragen an die KI stellen' : 'Ask clinical questions with AI');

  String get badgeActive => _isTr ? 'AKTİF' : (_isDe ? 'AKTIV' : 'ACTIVE');
  String get badgeSoon => _isTr ? 'YAKINDA' : (_isDe ? 'BALD' : 'SOON');
  String get cardTapToOpen =>
      _isTr ? 'Açmak için dokun' : (_isDe ? 'Tippen zum Öffnen' : 'Tap to open');

  String get themeLightTooltip => _isTr
      ? 'Açık temaya geç'
      : (_isDe ? 'Heller Modus' : 'Switch to light mode');
  String get themeDarkTooltip => _isTr
      ? 'Koyu temaya geç'
      : (_isDe ? 'Dunkler Modus' : 'Switch to dark mode');

  // ── Chat ─────────────────────────────────────────────────────────────────-
  String get chatDashboardTitle =>
      _isTr ? 'Klinik Sohbet' : (_isDe ? 'Klinischer Chat' : 'Clinical Chat');
  String get chatNewChat =>
      _isTr ? 'Yeni sohbet' : (_isDe ? 'Neuer Chat' : 'New chat');
  String get chatNewSessionTitle =>
      _isTr ? 'Yeni sohbet' : (_isDe ? 'Neuer Chat' : 'New chat');
  String get chatEmptyTitle => _isTr
      ? 'Henüz sohbet yok'
      : (_isDe ? 'Keine Gespräche' : 'No conversations yet');
  String get chatEmptySubtitle => _isTr
      ? 'Yeni bir klinik sohbet başlatarak geçmişinizi oluşturun.'
      : (_isDe
          ? 'Starten Sie einen neuen Chat.'
          : 'Start a new clinical chat to build your history.');
  String get chatInputHint => _isTr
      ? 'Klinik bir soru yazın...'
      : (_isDe ? 'Frage stellen...' : 'Ask a clinical question...');
  String get chatTyping =>
      _isTr ? 'Düşünüyor...' : (_isDe ? 'Denkt nach...' : 'Thinking...');
  String get chatLimitTitle => _isTr
      ? 'Ücretsiz limit doldu'
      : (_isDe ? 'Limit erreicht' : 'Free tier limit reached');
  String get chatLimitBody => _isTr
      ? '3 ücretsiz soruyu kullandınız. Devam etmek için premiuma yükseltin.'
      : (_isDe
          ? 'Kostenlose Fragen verbraucht. Upgrade auf Premium.'
          : 'You have used your 3 free questions. Upgrade to premium to continue.');
  String get chatUpgradeSubtitle => _isTr
      ? 'Sınırsız klinik sohbet, öncelikli yanıtlar ve daha zengin bağlam.'
      : (_isDe
          ? 'Unbegrenzter Chat und Priorität.'
          : 'Unlimited clinical chat, priority responses, and richer context.');
  String get chatGoPremium =>
      _isTr ? 'Premiuma Geç' : (_isDe ? 'Premium abschließen' : 'Go Premium');
  String get chatWelcomeMessage => _isTr
      ? 'PharmAI bugün size nasıl yardımcı olabilir?'
      : (_isDe ? 'Wie kann PharmAI Ihnen heute helfen?' : 'How can PharmAI help you today?');

  // ── ICD-10 search page ─────────────────────────────────────────────────────
  String get icd10SearchTitle =>
      _isTr ? 'ICD-10 Ara' : (_isDe ? 'ICD-10 Suche' : 'ICD-10 Search');
  String get searchPlaceholder => _isTr
      ? 'ICD-10 kodu veya tanım ara…'
      : (_isDe ? 'Code oder Beschreibung...' : 'Search ICD-10 code or description…');
  String get searchHint => _isTr
      ? 'ICD-10 kodu veya tanımını girin'
      : (_isDe ? 'ICD-10 Code eingeben' : 'Enter an ICD-10 code or description');
  String get searchHintExample => _isTr
      ? 'Örn: "E11", "diabetes", "J00"'
      : (_isDe ? 'z.B. "E11", "Diabetes"' : 'e.g. "E11", "diabetes", "J00"');
  String searchEmpty(String query) => _isTr
      ? '"$query" için sonuç bulunamadı'
      : (_isDe ? 'Keine Ergebnisse für "$query"' : 'No results for "$query"');
  String get searchBack => _isTr ? 'Geri' : (_isDe ? 'Zurück' : 'Back');
  String get searchClear => _isTr ? 'Temizle' : (_isDe ? 'Löschen' : 'Clear');

  // ── Drug search page ───────────────────────────────────────────────────────
  String get drugSearchPlaceholder => _isTr
      ? 'İlaç adı, etken madde veya ATC kodu ara…'
      : (_isDe
          ? 'Medikament oder Wirkstoff suchen...'
          : 'Search drug name, ingredient, or ATC code…');
  String get drugSearchHint => _isTr
      ? 'İlaç adı veya etken madde girin'
      : (_isDe ? 'Wirkstoff eingeben' : 'Enter a drug name or active ingredient');
  String get drugSearchHintExample => _isTr
      ? 'Örn: "Aspirin", "Etodolak", "M01AB08"'
      : (_isDe ? 'z.B. "Aspirin", "Ibuprofen"' : 'e.g. "Aspirin", "Etodolac", "M01AB08"');

  // ── Calculators ────────────────────────────────────────────────────────────
  String get calcBmiCitation => _isTr
      ? 'WHO Teknik Rapor Serisi 854 (1995)'
      : 'WHO Technical Report Series 854 (1995)';
  String get calcTitle =>
      _isTr ? 'Klinik Hesaplayıcılar' : (_isDe ? 'Rechner' : 'Clinical Calculators');
  String get calcCalculate =>
      _isTr ? 'Hesapla' : (_isDe ? 'Berechnen' : 'Calculate');
  String get calcInfoTooltip => _isTr
      ? 'Formül ve kaynak bilgisi'
      : (_isDe ? 'Formel und Quelle' : 'Formula and source');
  String get calcInfoTitle => _isTr
      ? 'Kanıt ve Formül'
      : (_isDe ? 'Evidenz und Formel' : 'Evidence and Formula');
  String get calcFormulaLabel =>
      _isTr ? 'Formül' : (_isDe ? 'Formel' : 'Formula');
  String get calcReferenceLabel =>
      _isTr ? 'Referans' : (_isDe ? 'Referenz' : 'Reference');
  String get calcBmiTitle => _isTr
      ? 'Vücut Kitle İndeksi (VKİ)'
      : (_isDe ? 'Body Mass Index (BMI)' : 'Body Mass Index (BMI)');
  String get calcBmiFormula => _isTr
      ? '• BMI = ağırlık(kg) / [boy(m)]^2'
      : '• BMI = weight(kg) / [height(m)]^2';
  String get calcBmiReference => _isTr
      ? 'WHO Technical Report Series 854 (1995)'
      : 'WHO Technical Report Series 854 (1995)';
  String get calcGfrTitle => _isTr
      ? 'Glomerüler Filtrasyon Hızı (GFH)'
      : (_isDe ? 'GFR' : 'Glomerular Filtration Rate (GFR)');
  String get calcGfrFormula => _isTr
      ? '• CKD-EPI 2021 Cockcroft-Gault (doz ayarı)'
      : '• CKD-EPI 2021 Cockcroft-Gault (dose adjustment)';
  String get calcGfrReference => _isTr
      ? 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022'
      : 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022';
  String get calcWeight => _isTr ? 'Ağırlık' : (_isDe ? 'Gewicht' : 'Weight');
  String get calcHeight => _isTr ? 'Boy' : (_isDe ? 'Größe' : 'Height');
  String get calcAge => _isTr ? 'Yaş' : (_isDe ? 'Alter' : 'Age');
  String get calcSerumCreatinine => _isTr
      ? 'Serum Kreatinin'
      : (_isDe ? 'Serum-Kreatinin' : 'Serum Creatinine');
  String get calcMale => _isTr ? 'Erkek' : (_isDe ? 'Männlich' : 'Male');
  String get calcFemale => _isTr ? 'Kadın' : (_isDe ? 'Weiblich' : 'Female');
  String get calcPediatricWeightTitle => _isTr
      ? 'Pediatrik Tahmini Ağırlık (APLS)'
      : (_isDe ? 'Pädiatrisch geschätztes Gewicht' : 'Pediatric Estimated Weight (APLS)');
  String get calcPediatricWeightFormula => _isTr
      ? '• 1-12 ay: (0.5 x ay) + 4\n• 1-5 yaş: (2 x yaş) + 8\n• 6-12 yaş: (3 x yaş) + 7'
      : '• 1-12 months: (0.5 x months) + 4\n• 1-5 years: (2 x age) + 8\n• 6-12 years: (3 x age) + 7';
  String get calcPediatricWeightReference => _isTr
      ? 'Referans: APLS Kılavuzu'
      : (_isDe ? 'Referenz: APLS-Richtlinien' : 'Reference: APLS Guidelines');
  String get calcPediatricWeightCitation => _isTr
      ? 'Updated APLS formülleri (1-12 ay, 1-12 yaş)'
      : 'Updated APLS formulas (1-12 months, 1-12 years)';
  String get calcIvDripRateTitle =>
      _isTr ? 'IV Damla Hızı' : (_isDe ? 'IV-Tropfrate' : 'IV Drip Rate');
  String get calcIvDripRateFormula => _isTr
      ? '• Damla/dk = [Hacim(mL) x Damla faktörü(gtt/mL)]\n / Süre(dk)'
      : '• Drops/min = [Volume(mL) x Drop factor(gtt/mL)]\n / Time(min)';
  String get calcIvDripRateReference => _isTr
      ? 'Referans: İnfüzyon Tedavi Standartları'
      : (_isDe ? 'Referenz: Infusionstherapie-Standards' : 'Reference: Infusion Therapy Standards');
  String get calcIvDripRateCitation => _isTr
      ? 'Damla/dk = (Hacim x Damla Faktörü) / Süre(dk)'
      : 'Drops/min = (Volume x Drop Factor) / Time(min)';
  String get calcAgeUnit =>
      _isTr ? 'Yaş Birimi' : (_isDe ? 'Alterseinheit' : 'Age Unit');
  String get calcMonths => _isTr ? 'Ay' : (_isDe ? 'Monate' : 'Months');
  String get calcYears => _isTr ? 'Yıl' : (_isDe ? 'Jahre' : 'Years');
  String get calcMonthsShort => _isTr ? 'ay' : (_isDe ? 'Mo.' : 'mo');
  String get calcYearsShort => _isTr ? 'yıl' : (_isDe ? 'J.' : 'yr');
  String get calcHours => _isTr ? 'Saat' : (_isDe ? 'Stunden' : 'Hours');
  String get calcMinutes => _isTr ? 'Dakika' : (_isDe ? 'Minuten' : 'Minutes');
  String get calcHoursShort => _isTr ? 'saat' : (_isDe ? 'Std.' : 'hr');
  String get calcMinutesShort => _isTr ? 'dk' : (_isDe ? 'Min.' : 'min');
  String get calcVolumeMl => _isTr ? 'Hacim (mL)' : (_isDe ? 'Volumen (ml)' : 'Volume (mL)');
  String get calcDropFactor =>
      _isTr ? 'Damla Faktörü' : (_isDe ? 'Tropffaktor' : 'Drop Factor');
  String get calcTotalTime =>
      _isTr ? 'Toplam Süre' : (_isDe ? 'Gesamtzeit' : 'Total Time');
  String get calcTimeUnit =>
      _isTr ? 'Süre Birimi' : (_isDe ? 'Zeiteinheit' : 'Time Unit');
  String get calcDropsPerMinute =>
      _isTr ? 'Damla / dakika' : (_isDe ? 'Tropfen / Minute' : 'Drops / minute');
  String get calcDropsPerMinuteUnit =>
      _isTr ? 'gtt/dk' : (_isDe ? 'gtt/Min' : 'gtt/min');
  String get calcEstimatedWeight => _isTr
      ? 'Tahmini Ağırlık'
      : (_isDe ? 'Geschätztes Gewicht' : 'Estimated Weight');
  String get calcKgUnit => 'kg';
  String get calcMlUnit => 'mL';
  String calcDropFactorOption(int value) => '$value gtt/mL';
  String get calcCmUnit => 'cm';
  String get calcMgDlUnit => 'mg/dL';
  String get calcGfrCitation => _isTr
      ? 'CKD-EPI 2021 · Inker ve ark., NEJM 385:1737 · Cockcroft-Gault, Nephron 1976 · KDIGO 2022'
      : 'CKD-EPI 2021 · Inker et al., NEJM 385:1737 · Cockcroft-Gault, Nephron 1976 · KDIGO 2022';

  // ── Auth & Profile ─────────────────────────────────────────────────────────
  String get signInWithGoogle => _isTr
      ? 'Google ile Giriş Yap'
      : (_isDe ? 'Mit Google anmelden' : 'Sign in with Google');
  String get signInWithApple => _isTr
      ? 'Apple ile Giriş Yap'
      : (_isDe ? 'Mit Apple anmelden' : 'Sign in with Apple');
  String get continueAsGuest => _isTr
      ? 'Misafir Olarak Devam Et'
      : (_isDe ? 'Als Gast fortfahren' : 'Continue as Guest');
  String get signOut =>
      _isTr ? 'Çıkış Yap' : (_isDe ? 'Abmelden' : 'Sign Out');
  String get profile => _isTr ? 'Profil' : (_isDe ? 'Profil' : 'Profile');
  String get customName => _isTr ? 'Görünen Ad' : (_isDe ? 'Anzeigename' : 'Display Name');
  String get darkMode =>
      _isTr ? 'Koyu Tema' : (_isDe ? 'Dunkler Modus' : 'Dark Mode');
  String get languageTurkish => _isTr ? 'Türkçe' : 'Turkish';
  String get bookmarks =>
      _isTr ? 'Kaydedilenler' : (_isDe ? 'Lesezeichen' : 'Bookmarks');
  String get navProfile => _isTr ? 'Profil' : (_isDe ? 'Profil' : 'Profile');

  // New keys for Midnight Theme and German support
  String get themeMidnight => _isTr ? 'Gece Yarısı' : (_isDe ? 'Mitternacht' : 'Midnight');
  String get languageGerman => _isTr ? 'Almanca' : (_isDe ? 'Deutsch' : 'German');
  String get languageEnglish => _isTr ? 'İngilizce' : (_isDe ? 'Englisch' : 'English');
  String get themeLabel => _isTr ? 'Tema' : (_isDe ? 'Design' : 'Theme');
  String get languageLabel => _isTr ? 'Dil' : (_isDe ? 'Sprache' : 'Language');

  // ── Medical Citations & Disclaimer (Guideline 1.4.1) ───────────────────────
  String get icd10Citation => _isTr
      ? 'Kaynak: WHO Uluslararası Hastalık Sınıflandırması, 10. Revizyon (ICD-10), 2019 Baskısı'
      : (_isDe
          ? 'Quelle: WHO Internationale Klassifikation der Krankheiten, 10. Revision (ICD-10), Ausgabe 2019'
          : 'Source: WHO International Classification of Diseases, 10th Revision (ICD-10), 2019 Edition');
  String get icd10CitationShort => _isTr
      ? 'WHO ICD-10, 2019'
      : 'WHO ICD-10, 2019';
  String get drugCitation => _isTr
      ? 'Kaynak: TİTCK (Türkiye İlaç ve Tıbbi Cihaz Kurumu) Ruhsatlı İlaç Veritabanı'
      : (_isDe
          ? 'Quelle: TİTCK (Türkische Arzneimittelbehörde) Lizenzierte Arzneimitteldatenbank'
          : 'Source: TİTCK (Turkish Medicines and Medical Devices Agency) Licensed Drug Database');
  String get drugCitationShort => _isTr
      ? 'TİTCK Ruhsatlı İlaç Veritabanı'
      : (_isDe
          ? 'TİTCK Arzneimitteldatenbank'
          : 'TİTCK Licensed Drug Database');
  String get medicalDisclaimer => _isTr
      ? 'Bu uygulama yalnızca bilgilendirme amaçlıdır ve profesyonel tıbbi tavsiyenin yerine geçmez. Tüm tıbbi veriler WHO ICD-10 (2019), TİTCK Ruhsatlı İlaç Veritabanı ve hakemli klinik literatürden alınmıştır.'
      : (_isDe
          ? 'Diese App dient nur zu Informationszwecken und ersetzt keine professionelle medizinische Beratung. Alle medizinischen Daten stammen aus WHO ICD-10 (2019), TİTCK-Arzneimitteldatenbank und peer-reviewter klinischer Literatur.'
          : 'This app is for informational purposes only and does not replace professional medical advice. All medical data is sourced from WHO ICD-10 (2019), TİTCK Licensed Drug Database, and peer-reviewed clinical literature.');
  String get medicalDisclaimerTitle => _isTr
      ? 'Tıbbi Sorumluluk Reddi'
      : (_isDe ? 'Medizinischer Haftungsausschluss' : 'Medical Disclaimer');
  String get sourceLabel => _isTr
      ? 'Kaynak'
      : (_isDe ? 'Quelle' : 'Source');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['tr', 'en', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
