// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PharmAI';

  @override
  String get appTagline => 'Clinical Decision Support Platform';

  @override
  String get dashboardTitle => 'Clinical Dashboard';

  @override
  String get dashboardWelcome => 'Welcome';

  @override
  String get onboardingTitle => 'Quick App Tour';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingBack => 'Back';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingDone => 'Done';

  @override
  String get onboardingStepWelcomeTitle => 'Clinical support in one place';

  @override
  String get onboardingStepWelcomeDescription => 'PharmAI combines diagnostic search, drug insights, and calculators in one fast workflow.';

  @override
  String get onboardingStepIcdTitle => 'ICD-10 Search';

  @override
  String get onboardingStepIcdDescription => 'Find ICD-10 entries in seconds by typing a code or diagnosis description.';

  @override
  String get onboardingStepDrugTitle => 'Drug Information';

  @override
  String get onboardingStepDrugDescription => 'Review active ingredient, ATC code, and detailed medication notes from a single view.';

  @override
  String get onboardingStepCalcTitle => 'Clinical Calculators';

  @override
  String get onboardingStepCalcDescription => 'Use BMI, GFR, pediatric weight, and IV drip tools with transparent evidence details.';

  @override
  String get features => 'Features';

  @override
  String get homeFeaturesSubtitle => 'Fast access to core clinical tools.';

  @override
  String get navIcd10 => 'ICD-10 Search';

  @override
  String get navDrugInfo => 'Drug Info';

  @override
  String get navCalculators => 'Calculators';

  @override
  String get icd10Subtitle => 'Fast code and definition lookup';

  @override
  String get drugInfoSubtitle => 'Current drug reference';

  @override
  String get calculatorsSubtitle => 'BMI, GFR and clinical scores';

  @override
  String get badgeActive => 'ACTIVE';

  @override
  String get badgeSoon => 'SOON';

  @override
  String get cardTapToOpen => 'Tap to open';

  @override
  String get themeLightTooltip => 'Switch to light mode';

  @override
  String get themeDarkTooltip => 'Switch to dark mode';

  @override
  String get icd10SearchTitle => 'ICD-10 Search';

  @override
  String get searchPlaceholder => 'Search ICD-10 code or description…';

  @override
  String get searchHint => 'Enter an ICD-10 code or description';

  @override
  String get searchHintExample => 'e.g. \"E11\", \"diabetes\", \"J00\"';

  @override
  String searchEmpty(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get searchBack => 'Back';

  @override
  String get searchClear => 'Clear';

  @override
  String get calcInfoTooltip => 'Formula and source';

  @override
  String get calcInfoTitle => 'Evidence and Formula';

  @override
  String get calcFormulaLabel => 'Formula';

  @override
  String get calcReferenceLabel => 'Reference';

  @override
  String get calcBmiFormula => 'BMI = weight(kg) / [height(m)]^2';

  @override
  String get calcBmiReference => 'WHO Technical Report Series 854 (1995)';

  @override
  String get calcGfrFormula => 'CKD-EPI 2021 + Cockcroft-Gault (dose adjustment)';

  @override
  String get calcGfrReference => 'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022';

  @override
  String get calcPediatricWeightTitle => 'Pediatric Estimated Weight (APLS)';

  @override
  String get calcPediatricWeightFormula => '1-12 months: (0.5 x months) + 4, 1-5 years: (2 x age) + 8, 6-12 years: (3 x age) + 7';

  @override
  String get calcPediatricWeightReference => 'Reference: APLS Guidelines';

  @override
  String get calcIvDripRateTitle => 'IV Drip Rate';

  @override
  String get calcIvDripRateFormula => 'Drops/min = [Volume(mL) x Drop factor(gtt/mL)] / Time(min)';

  @override
  String get calcIvDripRateReference => 'Reference: Infusion Therapy Standards';

  @override
  String get calcAge => 'Age';

  @override
  String get calcAgeUnit => 'Age Unit';

  @override
  String get calcMonths => 'Months';

  @override
  String get calcYears => 'Years';

  @override
  String get calcVolumeMl => 'Volume (mL)';

  @override
  String get calcDropFactor => 'Drop Factor';

  @override
  String get calcTotalTime => 'Total Time';

  @override
  String get calcTimeUnit => 'Time Unit';

  @override
  String get calcHours => 'Hours';

  @override
  String get calcMinutes => 'Minutes';

  @override
  String get calcDropsPerMinute => 'Drops/min';

  @override
  String get calcEstimatedWeight => 'Estimated Weight';

  @override
  String get calcKgUnit => 'kg';

  @override
  String get calcDropsPerMinuteUnit => 'gtt/min';

  @override
  String get calcPediatricWeightCitation => 'Updated APLS formulas (1-12 months, 1-12 years)';

  @override
  String get calcIvDripRateCitation => 'Drops/min = (Volume x Drop Factor) / Time(min)';

  @override
  String get navChat => 'Clinical Chat';

  @override
  String get chatSubtitle => 'Ask clinical questions with AI';

  @override
  String get chatDashboardTitle => 'Clinical Chat';

  @override
  String get chatNewChat => 'New chat';

  @override
  String get chatNewSessionTitle => 'New chat';

  @override
  String get chatEmptyTitle => 'No conversations yet';

  @override
  String get chatEmptySubtitle => 'Start a new clinical chat to build your history.';

  @override
  String get chatInputHint => 'Ask a clinical question...';

  @override
  String get chatTyping => 'Thinking...';

  @override
  String get chatLimitTitle => 'Free tier limit reached';

  @override
  String get chatLimitBody => 'You have used your 3 free questions. Upgrade to premium to continue.';

  @override
  String get chatUpgradeSubtitle => 'Unlimited clinical chat, priority responses, and richer context.';

  @override
  String get chatGoPremium => 'Go Premium';

  @override
  String get chatWelcomeMessage => 'How can PharmAI help you today?';

  @override
  String get chatErrorLocalSave => 'Could not save locally. Please try again.';

  @override
  String get chatRenameAction => 'Rename chat';

  @override
  String get chatRenameTitle => 'Rename chat';

  @override
  String get chatRenameHint => 'Short, descriptive title';

  @override
  String get chatRenameCancel => 'Cancel';

  @override
  String get chatRenameSave => 'Save';
}
