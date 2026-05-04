import 'dart:math' as math;

import 'package:fpdart/fpdart.dart';

import 'package:pharmai/core/constants/app_constants.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

/// All medical calculation algorithms for PharmAI.
///
/// Design contract (ProjectRules §6):
///   • Pure static methods — no instance state, no I/O, no Flutter imports.
///   • Every input is validated before arithmetic is attempted.
///   • Returns `Either<ValidationFailure, Result>`: callers never see exceptions.
///   • Every formula is cited so it can be audited against source literature.
abstract class CalculatorEngine {
  CalculatorEngine._();

  // ── BMI ──────────────────────────────────────────────────────────────────────

  /// Body Mass Index (adults ≥18 years).
  ///
  /// Formula : BMI = weight(kg) / height(m)²
  /// Reference: WHO Technical Report Series 854 (1995).
  static Either<ValidationFailure, BmiResult> calculateBmi({
    required double weightKg,
    required double heightCm,
  }) {
    final weightErr = _validateWeight(weightKg);
    if (weightErr != null) return left(ValidationFailure(weightErr));

    final heightErr = _validateHeight(heightCm);
    if (heightErr != null) return left(ValidationFailure(heightErr));

    final heightM = heightCm / 100.0;
    final bmi = weightKg / (heightM * heightM);

    return right(BmiResult(bmi: _round2(bmi), category: _classifyBmi(bmi)));
  }

  // ── GFR ──────────────────────────────────────────────────────────────────────

  /// Estimated GFR using two complementary equations.
  ///
  /// ① CKD-EPI 2021 creatinine (race-free) — preferred for CKD staging.
  ///   Reference: Inker LA et al. NEJM 2021;385:1737-1749.
  ///   eGFR = 142 × min(Scr/κ, 1)^α × max(Scr/κ, 1)^(-1.200) × 0.9938^Age × [1.012 if female]
  ///   Female: κ = 0.7, α = -0.241 | Male: κ = 0.9, α = -0.302
  ///
  /// ② Cockcroft-Gault — used for drug-dosing adjustments.
  ///   Reference: Cockcroft DW, Gault MH. Nephron 1976;16(1):31-41.
  ///   CrCl = ((140 − age) × weight) / (72 × Scr) × [0.85 if female]
  ///
  /// CKD staging follows KDIGO 2022 Clinical Practice Guideline.
  static Either<ValidationFailure, GfrResult> calculateGfr({
    required double serumCreatinineMgDl,
    required int ageYears,
    required BiologicalSex sex,
    required double weightKg,
  }) {
    final scrErr = _validateCreatinine(serumCreatinineMgDl);
    if (scrErr != null) return left(ValidationFailure(scrErr));

    final ageErr = _validateAge(ageYears);
    if (ageErr != null) return left(ValidationFailure(ageErr));

    final weightErr = _validateWeight(weightKg);
    if (weightErr != null) return left(ValidationFailure(weightErr));

    final ckdEpi = _ckdEpi2021(serumCreatinineMgDl, ageYears, sex);
    final cg = _cockcroftGault(serumCreatinineMgDl, ageYears, sex, weightKg);

    return right(GfrResult(
      ckdEpi2021: _round1(ckdEpi),
      cockcroftGault: _round1(cg),
      ckdStage: _classifyCkd(ckdEpi),
    ));
  }

  // ── Algorithms ───────────────────────────────────────────────────────────────

  static double _ckdEpi2021(
    double scr,
    int age,
    BiologicalSex sex,
  ) {
    final isFemale = sex == BiologicalSex.female;
    final kappa = isFemale ? 0.7 : 0.9;
    final alpha = isFemale ? -0.241 : -0.302;
    final sexFactor = isFemale ? 1.012 : 1.0;
    final ratio = scr / kappa;

    return 142.0 *
        math.pow(math.min(ratio, 1.0), alpha) *
        math.pow(math.max(ratio, 1.0), -1.200) *
        math.pow(0.9938, age.toDouble()) *
        sexFactor;
  }

  static double _cockcroftGault(
    double scr,
    int age,
    BiologicalSex sex,
    double weightKg,
  ) {
    final sexFactor = sex == BiologicalSex.female ? 0.85 : 1.0;
    return ((140.0 - age) * weightKg) / (72.0 * scr) * sexFactor;
  }

  // ── Classification ───────────────────────────────────────────────────────────

  static BmiCategory _classifyBmi(double bmi) {
    if (bmi < 16.0) return BmiCategory.severelyUnderweight;
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25.0) return BmiCategory.normalWeight;
    if (bmi < 30.0) return BmiCategory.overweight;
    if (bmi < 35.0) return BmiCategory.obeseClassI;
    if (bmi < 40.0) return BmiCategory.obeseClassII;
    return BmiCategory.obeseClassIII;
  }

  static CkdStage _classifyCkd(double egfr) {
    if (egfr >= 90.0) return CkdStage.g1;
    if (egfr >= 60.0) return CkdStage.g2;
    if (egfr >= 45.0) return CkdStage.g3a;
    if (egfr >= 30.0) return CkdStage.g3b;
    if (egfr >= 15.0) return CkdStage.g4;
    return CkdStage.g5;
  }

  // ── Validation ───────────────────────────────────────────────────────────────

  static String? _validateWeight(double kg) {
    if (!kg.isFinite) return 'Weight must be a finite number.';
    if (kg < AppConstants.minWeightKg) {
      return 'Weight must be at least ${AppConstants.minWeightKg} kg.';
    }
    if (kg > AppConstants.maxWeightKg) {
      return 'Weight must be at most ${AppConstants.maxWeightKg} kg.';
    }
    return null;
  }

  static String? _validateHeight(double cm) {
    if (!cm.isFinite) return 'Height must be a finite number.';
    if (cm < AppConstants.minHeightCm) {
      return 'Height must be at least ${AppConstants.minHeightCm} cm.';
    }
    if (cm > AppConstants.maxHeightCm) {
      return 'Height must be at most ${AppConstants.maxHeightCm} cm.';
    }
    return null;
  }

  static String? _validateAge(int years) {
    if (years < AppConstants.minAgeYears) {
      return 'Age must be at least ${AppConstants.minAgeYears} years.';
    }
    if (years > AppConstants.maxAgeYears) {
      return 'Age must be at most ${AppConstants.maxAgeYears} years.';
    }
    return null;
  }

  static String? _validateCreatinine(double mgDl) {
    if (!mgDl.isFinite) return 'Serum creatinine must be a finite number.';
    if (mgDl < AppConstants.minSerumCreatinine) {
      return 'Serum creatinine must be at least '
          '${AppConstants.minSerumCreatinine} mg/dL.';
    }
    if (mgDl > AppConstants.maxSerumCreatinine) {
      return 'Serum creatinine must be at most '
          '${AppConstants.maxSerumCreatinine} mg/dL.';
    }
    return null;
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  static double _round1(double v) => (v * 10.0).round() / 10.0;
  static double _round2(double v) => (v * 100.0).round() / 100.0;
}
