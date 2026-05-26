// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'PharmAI';

  @override
  String get appTagline => 'Klinik Karar Destek Platformu';

  @override
  String get dashboardTitle => 'Klinik Panel';

  @override
  String get dashboardWelcome => 'Hoş geldiniz';

  @override
  String get onboardingTitle => 'Hızlı Uygulama Turu';

  @override
  String get onboardingSkip => 'Geç';

  @override
  String get onboardingBack => 'Geri';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingDone => 'Tamam';

  @override
  String get onboardingStepWelcomeTitle => 'Klinik destek tek ekranda';

  @override
  String get onboardingStepWelcomeDescription => 'PharmAI, tanısal arama, ilaç bilgisi ve hesaplayıcıları hızlı bir akışta birleştirir.';

  @override
  String get onboardingStepIcdTitle => 'ICD-10 Arama';

  @override
  String get onboardingStepIcdDescription => 'Kod veya tanım yazarak ilgili ICD-10 kayıtlarına saniyeler içinde ulaşın.';

  @override
  String get onboardingStepDrugTitle => 'İlaç Bilgisi';

  @override
  String get onboardingStepDrugDescription => 'Etken madde, ATC kodu ve detaylı açıklamaları tek noktadan inceleyin.';

  @override
  String get onboardingStepCalcTitle => 'Klinik Hesaplayıcılar';

  @override
  String get onboardingStepCalcDescription => 'BMI, GFH, pediatrik ağırlık ve IV damla hızı sonuçlarını kanıta dayalı formül bilgisiyle görün.';

  @override
  String get features => 'Özellikler';

  @override
  String get homeFeaturesSubtitle => 'Temel klinik araçlara hızlı erişim.';

  @override
  String get navIcd10 => 'ICD-10 Arama';

  @override
  String get navDrugInfo => 'İlaç Bilgisi';

  @override
  String get navCalculators => 'Hesaplayıcılar';

  @override
  String get icd10Subtitle => 'Hızlı kod ve tanım araması';

  @override
  String get drugInfoSubtitle => 'Güncel ilaç rehberi';

  @override
  String get calculatorsSubtitle => 'BMI, GFH ve klinik skorlar';

  @override
  String get badgeActive => 'AKTİF';

  @override
  String get badgeSoon => 'YAKINDA';

  @override
  String get cardTapToOpen => 'Açmak için dokun';

  @override
  String get themeLightTooltip => 'Açık temaya geç';

  @override
  String get themeDarkTooltip => 'Koyu temaya geç';

  @override
  String get icd10SearchTitle => 'ICD-10 Ara';

  @override
  String get searchPlaceholder => 'ICD-10 kodu veya tanım ara…';

  @override
  String get searchHint => 'ICD-10 kodu veya tanımını girin';

  @override
  String get searchHintExample => 'Örn: \"E11\", \"diabetes\", \"J00\"';

  @override
  String searchEmpty(String query) {
    return '\"$query\" için sonuç bulunamadı';
  }

  @override
  String get searchBack => 'Geri';

  @override
  String get searchClear => 'Temizle';

  @override
  String get calcInfoTooltip => 'Formül ve kaynak bilgisi';

  @override
  String get calcInfoTitle => 'Kanıt ve Formül';

  @override
  String get calcFormulaLabel => 'Formül';

  @override
  String get calcReferenceLabel => 'Referans';

  @override
  String get calcBmiFormula => 'BMI = ağırlık(kg) / [boy(m)]^2';

  @override
  String get calcBmiReference => 'WHO Technical Report Series 854 (1995)';

  @override
  String get calcGfrFormula => 'CKD-EPI 2021 + Cockcroft-Gault (doz ayarı)';

  @override
  String get calcGfrReference => 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022';

  @override
  String get calcPediatricWeightTitle => 'Pediatrik Tahmini Ağırlık';

  @override
  String get calcPediatricWeightFormula => '1-12 ay: (0.5 x ay) + 4, 1-5 yaş: (2 x yaş) + 8, 6-12 yaş: (3 x yaş) + 7';

  @override
  String get calcPediatricWeightReference => 'Referans: APLS Kılavuzu';

  @override
  String get calcIvDripRateTitle => 'IV Damla Hızı';

  @override
  String get calcIvDripRateFormula => 'Damla/dk = [Hacim(mL) x Damla faktörü(gtt/mL)] / Süre(dk)';

  @override
  String get calcIvDripRateReference => 'Referans: İnfüzyon Tedavi Standartları';

  @override
  String get calcAge => 'Yaş';

  @override
  String get calcAgeUnit => 'Yaş Birimi';

  @override
  String get calcMonths => 'Ay';

  @override
  String get calcYears => 'Yıl';

  @override
  String get calcVolumeMl => 'Hacim (mL)';

  @override
  String get calcDropFactor => 'Damla Faktörü';

  @override
  String get calcTotalTime => 'Toplam Süre';

  @override
  String get calcTimeUnit => 'Süre Birimi';

  @override
  String get calcHours => 'Saat';

  @override
  String get calcMinutes => 'Dakika';

  @override
  String get calcDropsPerMinute => 'Damla/dk';

  @override
  String get calcEstimatedWeight => 'Tahmini Ağırlık';

  @override
  String get calcKgUnit => 'kg';

  @override
  String get calcDropsPerMinuteUnit => 'gtt/dk';

  @override
  String get calcPediatricWeightCitation => 'Updated APLS formülleri (1-12 ay, 1-12 yaş)';

  @override
  String get calcIvDripRateCitation => 'Damla/dk = (Hacim x Damla Faktörü) / Süre(dk)';

  @override
  String get navChat => 'Klinik Sohbet';

  @override
  String get chatSubtitle => 'Yapay zeka ile klinik sorular sorun';

  @override
  String get chatDashboardTitle => 'Klinik Sohbet';

  @override
  String get chatNewChat => 'Yeni sohbet';

  @override
  String get chatNewSessionTitle => 'Yeni sohbet';

  @override
  String get chatEmptyTitle => 'Henüz sohbet yok';

  @override
  String get chatEmptySubtitle => 'Yeni bir klinik sohbet başlatarak geçmişinizi oluşturun.';

  @override
  String get chatInputHint => 'Klinik bir soru yazın...';

  @override
  String get chatTyping => 'Düşünüyor...';

  @override
  String get chatLimitTitle => 'Ücretsiz limit doldu';

  @override
  String get chatLimitBody => '3 ücretsiz soruyu kullandınız. Devam etmek için premiuma yükseltin.';

  @override
  String get chatUpgradeSubtitle => 'Sınırsız klinik sohbet, öncelikli yanıtlar ve daha zengin bağlam.';

  @override
  String get chatGoPremium => 'Premiuma Geç';
}
