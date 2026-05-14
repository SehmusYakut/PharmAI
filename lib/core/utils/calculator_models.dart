import 'package:equatable/equatable.dart';

/// Biological sex used as a clinical input variable.
/// Named "biological sex" (not gender) because GFR equations are based on
/// kidney mass differences that correlate with biological sex.
enum BiologicalSex { male, female }

/// Pediatric age unit for APLS estimated weight formulas.
enum PediatricAgeUnit { months, years }

/// Time unit used by IV drip rate calculator.
enum IvTimeUnit { hours, minutes }

/// WHO BMI classification (adults ≥18 years).
/// Reference: WHO Technical Report Series 854 (1995).
enum BmiCategory {
  severelyUnderweight, // BMI  < 16.0
  underweight, // BMI 16.0 – 18.49
  normalWeight, // BMI 18.5 – 24.99
  overweight, // BMI 25.0 – 29.99
  obeseClassI, // BMI 30.0 – 34.99
  obeseClassII, // BMI 35.0 – 39.99
  obeseClassIII, // BMI ≥ 40.0  (morbid obesity)
}

/// KDIGO CKD staging based on eGFR (mL/min/1.73 m²).
/// Reference: KDIGO 2022 Clinical Practice Guideline.
enum CkdStage {
  g1, // eGFR ≥ 90  — normal or high
  g2, // eGFR 60–89 — mildly decreased
  g3a, // eGFR 45–59 — mildly to moderately decreased
  g3b, // eGFR 30–44 — moderately to severely decreased
  g4, // eGFR 15–29 — severely decreased
  g5, // eGFR  < 15 — kidney failure
}

/// Immutable result of a BMI calculation.
class BmiResult extends Equatable {
  const BmiResult({required this.bmi, required this.category});

  /// Rounded to 2 decimal places (kg/m²).
  final double bmi;
  final BmiCategory category;

  @override
  List<Object> get props => [bmi, category];
}

/// Immutable result of a GFR calculation.
///
/// Both eGFR equations are returned so the caller can display or log
/// whichever is appropriate for the clinical context.
class GfrResult extends Equatable {
  const GfrResult({
    required this.ckdEpi2021,
    required this.cockcroftGault,
    required this.ckdStage,
  });

  /// CKD-EPI 2021 eGFR (mL/min/1.73 m²), rounded to 1 decimal place.
  /// Preferred for CKD staging (KDIGO 2022).
  final double ckdEpi2021;

  /// Cockcroft-Gault CrCl (mL/min), rounded to 1 decimal place.
  /// Preferred for drug dosing adjustments.
  final double cockcroftGault;

  /// CKD stage derived from [ckdEpi2021].
  final CkdStage ckdStage;

  @override
  List<Object> get props => [ckdEpi2021, cockcroftGault, ckdStage];
}

/// Immutable result of the pediatric estimated weight calculator.
class PediatricWeightResult extends Equatable {
  const PediatricWeightResult({required this.weightKg});

  /// Rounded to 1 decimal place.
  final double weightKg;

  @override
  List<Object> get props => [weightKg];
}

/// Immutable result of the IV drip rate calculator.
class IvDripRateResult extends Equatable {
  const IvDripRateResult({required this.dropsPerMinute});

  /// Rounded to nearest whole number.
  final int dropsPerMinute;

  @override
  List<Object> get props => [dropsPerMinute];
}
