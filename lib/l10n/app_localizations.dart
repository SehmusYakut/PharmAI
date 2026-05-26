import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PharmAI'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Clinical Decision Support Platform'**
  String get appTagline;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinical Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get dashboardWelcome;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick App Tour'**
  String get onboardingTitle;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboardingBack;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get onboardingDone;

  /// No description provided for @onboardingStepWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinical support in one place'**
  String get onboardingStepWelcomeTitle;

  /// No description provided for @onboardingStepWelcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'PharmAI combines diagnostic search, drug insights, and calculators in one fast workflow.'**
  String get onboardingStepWelcomeDescription;

  /// No description provided for @onboardingStepIcdTitle.
  ///
  /// In en, this message translates to:
  /// **'ICD-10 Search'**
  String get onboardingStepIcdTitle;

  /// No description provided for @onboardingStepIcdDescription.
  ///
  /// In en, this message translates to:
  /// **'Find ICD-10 entries in seconds by typing a code or diagnosis description.'**
  String get onboardingStepIcdDescription;

  /// No description provided for @onboardingStepDrugTitle.
  ///
  /// In en, this message translates to:
  /// **'Drug Information'**
  String get onboardingStepDrugTitle;

  /// No description provided for @onboardingStepDrugDescription.
  ///
  /// In en, this message translates to:
  /// **'Review active ingredient, ATC code, and detailed medication notes from a single view.'**
  String get onboardingStepDrugDescription;

  /// No description provided for @onboardingStepCalcTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinical Calculators'**
  String get onboardingStepCalcTitle;

  /// No description provided for @onboardingStepCalcDescription.
  ///
  /// In en, this message translates to:
  /// **'Use BMI, GFR, pediatric weight, and IV drip tools with transparent evidence details.'**
  String get onboardingStepCalcDescription;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @homeFeaturesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fast access to core clinical tools.'**
  String get homeFeaturesSubtitle;

  /// No description provided for @navIcd10.
  ///
  /// In en, this message translates to:
  /// **'ICD-10 Search'**
  String get navIcd10;

  /// No description provided for @navDrugInfo.
  ///
  /// In en, this message translates to:
  /// **'Drug Info'**
  String get navDrugInfo;

  /// No description provided for @navCalculators.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get navCalculators;

  /// No description provided for @icd10Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Fast code and definition lookup'**
  String get icd10Subtitle;

  /// No description provided for @drugInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Current drug reference'**
  String get drugInfoSubtitle;

  /// No description provided for @calculatorsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'BMI, GFR and clinical scores'**
  String get calculatorsSubtitle;

  /// No description provided for @badgeActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get badgeActive;

  /// No description provided for @badgeSoon.
  ///
  /// In en, this message translates to:
  /// **'SOON'**
  String get badgeSoon;

  /// No description provided for @cardTapToOpen.
  ///
  /// In en, this message translates to:
  /// **'Tap to open'**
  String get cardTapToOpen;

  /// No description provided for @themeLightTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch to light mode'**
  String get themeLightTooltip;

  /// No description provided for @themeDarkTooltip.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark mode'**
  String get themeDarkTooltip;

  /// No description provided for @icd10SearchTitle.
  ///
  /// In en, this message translates to:
  /// **'ICD-10 Search'**
  String get icd10SearchTitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search ICD-10 code or description…'**
  String get searchPlaceholder;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Enter an ICD-10 code or description'**
  String get searchHint;

  /// No description provided for @searchHintExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. \"E11\", \"diabetes\", \"J00\"'**
  String get searchHintExample;

  /// No description provided for @searchEmpty.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String searchEmpty(String query);

  /// No description provided for @searchBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get searchBack;

  /// No description provided for @searchClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get searchClear;

  /// No description provided for @calcInfoTooltip.
  ///
  /// In en, this message translates to:
  /// **'Formula and source'**
  String get calcInfoTooltip;

  /// No description provided for @calcInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Evidence and Formula'**
  String get calcInfoTitle;

  /// No description provided for @calcFormulaLabel.
  ///
  /// In en, this message translates to:
  /// **'Formula'**
  String get calcFormulaLabel;

  /// No description provided for @calcReferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get calcReferenceLabel;

  /// No description provided for @calcBmiFormula.
  ///
  /// In en, this message translates to:
  /// **'BMI = weight(kg) / [height(m)]^2'**
  String get calcBmiFormula;

  /// No description provided for @calcBmiReference.
  ///
  /// In en, this message translates to:
  /// **'WHO Technical Report Series 854 (1995)'**
  String get calcBmiReference;

  /// No description provided for @calcGfrFormula.
  ///
  /// In en, this message translates to:
  /// **'CKD-EPI 2021 + Cockcroft-Gault (dose adjustment)'**
  String get calcGfrFormula;

  /// No description provided for @calcGfrReference.
  ///
  /// In en, this message translates to:
  /// **'Inker et al., NEJM 2021; Cockcroft-Gault 1976; KDIGO 2022'**
  String get calcGfrReference;

  /// No description provided for @calcPediatricWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Pediatric Estimated Weight (APLS)'**
  String get calcPediatricWeightTitle;

  /// No description provided for @calcPediatricWeightFormula.
  ///
  /// In en, this message translates to:
  /// **'1-12 months: (0.5 x months) + 4, 1-5 years: (2 x age) + 8, 6-12 years: (3 x age) + 7'**
  String get calcPediatricWeightFormula;

  /// No description provided for @calcPediatricWeightReference.
  ///
  /// In en, this message translates to:
  /// **'Reference: APLS Guidelines'**
  String get calcPediatricWeightReference;

  /// No description provided for @calcIvDripRateTitle.
  ///
  /// In en, this message translates to:
  /// **'IV Drip Rate'**
  String get calcIvDripRateTitle;

  /// No description provided for @calcIvDripRateFormula.
  ///
  /// In en, this message translates to:
  /// **'Drops/min = [Volume(mL) x Drop factor(gtt/mL)] / Time(min)'**
  String get calcIvDripRateFormula;

  /// No description provided for @calcIvDripRateReference.
  ///
  /// In en, this message translates to:
  /// **'Reference: Infusion Therapy Standards'**
  String get calcIvDripRateReference;

  /// No description provided for @calcAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get calcAge;

  /// No description provided for @calcAgeUnit.
  ///
  /// In en, this message translates to:
  /// **'Age Unit'**
  String get calcAgeUnit;

  /// No description provided for @calcMonths.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get calcMonths;

  /// No description provided for @calcYears.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get calcYears;

  /// No description provided for @calcVolumeMl.
  ///
  /// In en, this message translates to:
  /// **'Volume (mL)'**
  String get calcVolumeMl;

  /// No description provided for @calcDropFactor.
  ///
  /// In en, this message translates to:
  /// **'Drop Factor'**
  String get calcDropFactor;

  /// No description provided for @calcTotalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get calcTotalTime;

  /// No description provided for @calcTimeUnit.
  ///
  /// In en, this message translates to:
  /// **'Time Unit'**
  String get calcTimeUnit;

  /// No description provided for @calcHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get calcHours;

  /// No description provided for @calcMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get calcMinutes;

  /// No description provided for @calcDropsPerMinute.
  ///
  /// In en, this message translates to:
  /// **'Drops/min'**
  String get calcDropsPerMinute;

  /// No description provided for @calcEstimatedWeight.
  ///
  /// In en, this message translates to:
  /// **'Estimated Weight'**
  String get calcEstimatedWeight;

  /// No description provided for @calcKgUnit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get calcKgUnit;

  /// No description provided for @calcDropsPerMinuteUnit.
  ///
  /// In en, this message translates to:
  /// **'gtt/min'**
  String get calcDropsPerMinuteUnit;

  /// No description provided for @calcPediatricWeightCitation.
  ///
  /// In en, this message translates to:
  /// **'Updated APLS formulas (1-12 months, 1-12 years)'**
  String get calcPediatricWeightCitation;

  /// No description provided for @calcIvDripRateCitation.
  ///
  /// In en, this message translates to:
  /// **'Drops/min = (Volume x Drop Factor) / Time(min)'**
  String get calcIvDripRateCitation;

  /// No description provided for @navChat.
  ///
  /// In en, this message translates to:
  /// **'Clinical Chat'**
  String get navChat;

  /// No description provided for @chatSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask clinical questions with AI'**
  String get chatSubtitle;

  /// No description provided for @chatDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinical Chat'**
  String get chatDashboardTitle;

  /// No description provided for @chatNewChat.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get chatNewChat;

  /// No description provided for @chatNewSessionTitle.
  ///
  /// In en, this message translates to:
  /// **'New chat'**
  String get chatNewSessionTitle;

  /// No description provided for @chatEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get chatEmptyTitle;

  /// No description provided for @chatEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new clinical chat to build your history.'**
  String get chatEmptySubtitle;

  /// No description provided for @chatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask a clinical question...'**
  String get chatInputHint;

  /// No description provided for @chatTyping.
  ///
  /// In en, this message translates to:
  /// **'Thinking...'**
  String get chatTyping;

  /// No description provided for @chatLimitTitle.
  ///
  /// In en, this message translates to:
  /// **'Free tier limit reached'**
  String get chatLimitTitle;

  /// No description provided for @chatLimitBody.
  ///
  /// In en, this message translates to:
  /// **'You have used your 3 free questions. Upgrade to premium to continue.'**
  String get chatLimitBody;

  /// No description provided for @chatUpgradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited clinical chat, priority responses, and richer context.'**
  String get chatUpgradeSubtitle;

  /// No description provided for @chatGoPremium.
  ///
  /// In en, this message translates to:
  /// **'Go Premium'**
  String get chatGoPremium;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
