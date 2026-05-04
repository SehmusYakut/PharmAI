// ignore_for_file: lines_longer_than_80_chars
//
// Reference values in this file are computed independently from the source
// equations listed in calculator_engine.dart so they act as a cross-check.
//
// Tolerances:
//   BMI          ±0.01  kg/m²         (pure arithmetic, near-exact)
//   CKD-EPI 2021 ±0.5   mL/min/1.73m² (involves pow/exp)
//   CG           ±0.01  mL/min        (pure arithmetic, near-exact)

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pharmai/core/error/failures.dart';
import 'package:pharmai/core/utils/calculator_engine.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

void main() {
  // ════════════════════════════════════════════════════════════════════════════
  // BMI
  // ════════════════════════════════════════════════════════════════════════════

  group('CalculatorEngine.calculateBmi', () {
    // ── Correct values ────────────────────────────────────────────────────────

    group('calculation accuracy', () {
      test('70 kg / 175 cm → 22.86 kg/m²', () {
        // 70 / 1.75² = 70 / 3.0625 = 22.8571…  → rounded 22.86
        final result = CalculatorEngine.calculateBmi(
          weightKg: 70.0,
          heightCm: 175.0,
        );
        expect(result.isRight(), isTrue);
        expect(result.getRight().toNullable()!.bmi, closeTo(22.86, 0.01));
      });

      test('90 kg / 170 cm → 31.14 kg/m²', () {
        // 90 / 1.70² = 90 / 2.89 = 31.1418…  → rounded 31.14
        final result = CalculatorEngine.calculateBmi(
          weightKg: 90.0,
          heightCm: 170.0,
        );
        expect(result.getRight().toNullable()!.bmi, closeTo(31.14, 0.01));
      });

      test('50 kg / 170 cm → 17.30 kg/m²', () {
        // 50 / 2.89 = 17.3010…  → rounded 17.30
        final result = CalculatorEngine.calculateBmi(
          weightKg: 50.0,
          heightCm: 170.0,
        );
        expect(result.getRight().toNullable()!.bmi, closeTo(17.30, 0.01));
      });

      test('rounds to exactly 2 decimal places', () {
        // 80 / 1.80² = 80 / 3.24 = 24.6913…  → rounded 24.69
        final result = CalculatorEngine.calculateBmi(
          weightKg: 80.0,
          heightCm: 180.0,
        );
        final bmi = result.getRight().toNullable()!.bmi;
        expect(bmi, closeTo(24.69, 0.01));
        // Confirm exactly 2 decimal places are stored
        final decimals = bmi.toString().split('.').last.length;
        expect(decimals, lessThanOrEqualTo(2));
      });
    });

    // ── BMI category classification ───────────────────────────────────────────

    group('classification', () {
      BmiCategory classify(double bmi) {
        // Use height=100 cm, compute matching weight:  weight = bmi * 1.0²
        return CalculatorEngine.calculateBmi(
          weightKg: bmi,
          heightCm: 100.0,
        ).getRight().toNullable()!.category;
      }

      test('BMI 15.9 → severelyUnderweight', () {
        expect(classify(15.9), BmiCategory.severelyUnderweight);
      });

      test('BMI 16.0 → underweight (boundary: first value NOT severely underweight)', () {
        expect(classify(16.0), BmiCategory.underweight);
      });

      test('BMI 18.4 → underweight', () {
        expect(classify(18.4), BmiCategory.underweight);
      });

      test('BMI 18.5 → normalWeight (boundary)', () {
        expect(classify(18.5), BmiCategory.normalWeight);
      });

      test('BMI 24.9 → normalWeight', () {
        expect(classify(24.9), BmiCategory.normalWeight);
      });

      test('BMI 25.0 → overweight (boundary)', () {
        expect(classify(25.0), BmiCategory.overweight);
      });

      test('BMI 29.9 → overweight', () {
        expect(classify(29.9), BmiCategory.overweight);
      });

      test('BMI 30.0 → obeseClassI (boundary)', () {
        expect(classify(30.0), BmiCategory.obeseClassI);
      });

      test('BMI 34.9 → obeseClassI', () {
        expect(classify(34.9), BmiCategory.obeseClassI);
      });

      test('BMI 35.0 → obeseClassII (boundary)', () {
        expect(classify(35.0), BmiCategory.obeseClassII);
      });

      test('BMI 39.9 → obeseClassII', () {
        expect(classify(39.9), BmiCategory.obeseClassII);
      });

      test('BMI 40.0 → obeseClassIII (boundary)', () {
        expect(classify(40.0), BmiCategory.obeseClassIII);
      });

      test('BMI 60.0 → obeseClassIII (extreme)', () {
        expect(classify(60.0), BmiCategory.obeseClassIII);
      });
    });

    // ── Input validation ──────────────────────────────────────────────────────

    group('validation — weight', () {
      void expectWeightFailure(double weight) {
        final result = CalculatorEngine.calculateBmi(
          weightKg: weight,
          heightCm: 170.0,
        );
        expect(result.isLeft(), isTrue,
            reason: 'weight $weight should be rejected');
        expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      }

      test('rejects weight = 0', () => expectWeightFailure(0.0));
      test('rejects weight = -1', () => expectWeightFailure(-1.0));
      test('rejects weight below minimum (0.4 kg)', () => expectWeightFailure(0.4));
      test('rejects weight above maximum (500.1 kg)', () => expectWeightFailure(500.1));
      test('rejects weight = double.nan', () => expectWeightFailure(double.nan));
      test('rejects weight = double.infinity', () => expectWeightFailure(double.infinity));
      test('rejects weight = double.negativeInfinity', () => expectWeightFailure(double.negativeInfinity));

      test('accepts minimum boundary weight (0.5 kg)', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 0.5,
          heightCm: 170.0,
        );
        expect(result.isRight(), isTrue);
      });

      test('accepts maximum boundary weight (500.0 kg)', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 500.0,
          heightCm: 170.0,
        );
        expect(result.isRight(), isTrue);
      });
    });

    group('validation — height', () {
      void expectHeightFailure(double height) {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 70.0,
          heightCm: height,
        );
        expect(result.isLeft(), isTrue,
            reason: 'height $height should be rejected');
        expect(result.getLeft().toNullable(), isA<ValidationFailure>());
      }

      test('rejects height = 0', () => expectHeightFailure(0.0));
      test('rejects height = -10', () => expectHeightFailure(-10.0));
      test('rejects height below minimum (29.9 cm)', () => expectHeightFailure(29.9));
      test('rejects height above maximum (300.1 cm)', () => expectHeightFailure(300.1));
      test('rejects height = double.nan', () => expectHeightFailure(double.nan));
      test('rejects height = double.infinity', () => expectHeightFailure(double.infinity));

      test('accepts minimum boundary height (30.0 cm)', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 3.0,
          heightCm: 30.0,
        );
        expect(result.isRight(), isTrue);
      });

      test('accepts maximum boundary height (300.0 cm)', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 200.0,
          heightCm: 300.0,
        );
        expect(result.isRight(), isTrue);
      });
    });

    group('validation — failure message content', () {
      test('weight below minimum carries a descriptive message', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: -5.0,
          heightCm: 170.0,
        );
        final msg = result.getLeft().toNullable()!.message;
        expect(msg, isNotEmpty);
        expect(msg.toLowerCase(), contains('weight'));
      });

      test('height below minimum carries a descriptive message', () {
        final result = CalculatorEngine.calculateBmi(
          weightKg: 70.0,
          heightCm: 0.0,
        );
        final msg = result.getLeft().toNullable()!.message;
        expect(msg, isNotEmpty);
        expect(msg.toLowerCase(), contains('height'));
      });
    });
  });

  // ════════════════════════════════════════════════════════════════════════════
  // GFR — CKD-EPI 2021
  // ════════════════════════════════════════════════════════════════════════════

  group('CalculatorEngine.calculateGfr — CKD-EPI 2021', () {
    // Reference values computed by hand from:
    //   eGFR = 142 × min(Scr/κ,1)^α × max(Scr/κ,1)^(-1.2) × 0.9938^Age × [1.012 if ♀]

    group('calculation accuracy', () {
      test('male, 50 y, Scr 1.0 → eGFR ≈ 91.7 mL/min/1.73m²', () {
        // κ=0.9, α=-0.302, Scr>κ: ratio=1.111
        // min=1 → 1.0; max=1.111 → 1.111^(-1.2) ≈ 0.8813
        // 0.9938^50 ≈ 0.7326
        // 142 × 1.0 × 0.8813 × 0.7326 ≈ 91.7
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.male,
          weightKg: 70.0,
        );
        expect(result.isRight(), isTrue);
        expect(result.getRight().toNullable()!.ckdEpi2021, closeTo(91.7, 0.5));
      });

      test('female, 50 y, Scr 1.0 → eGFR ≈ 68.6 mL/min/1.73m²', () {
        // κ=0.7, α=-0.241, Scr>κ: ratio=1.429
        // min=1 → 1.0; max=1.429 → 1.429^(-1.2) ≈ 0.6519
        // 0.9938^50 ≈ 0.7326; sexFactor=1.012
        // 142 × 1.0 × 0.6519 × 0.7326 × 1.012 ≈ 68.6
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.female,
          weightKg: 60.0,
        );
        expect(result.getRight().toNullable()!.ckdEpi2021, closeTo(68.6, 0.5));
      });

      test('male, 65 y, Scr 1.5 → eGFR ≈ 51.3 mL/min/1.73m²', () {
        // Scr/κ=1.667; 1.667^(-1.2) ≈ 0.5416; 0.9938^65 ≈ 0.6677
        // 142 × 0.5416 × 0.6677 ≈ 51.3
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.5,
          ageYears: 65,
          sex: BiologicalSex.male,
          weightKg: 70.0,
        );
        expect(result.getRight().toNullable()!.ckdEpi2021, closeTo(51.3, 0.5));
      });

      test('male, 30 y, Scr 0.7 → eGFR ≈ 127.1 mL/min/1.73m² (Scr < κ branch)', () {
        // Scr<κ: ratio=0.778; min=0.778 → 0.778^(-0.302) ≈ 1.079; max=1 → 1.0
        // 0.9938^30 ≈ 0.8299; 142 × 1.079 × 1.0 × 0.8299 ≈ 127.1
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 0.7,
          ageYears: 30,
          sex: BiologicalSex.male,
          weightKg: 75.0,
        );
        expect(result.getRight().toNullable()!.ckdEpi2021, closeTo(127.1, 0.8));
      });

      test('female, 25 y, Scr 0.5 → eGFR ≈ 133.7 mL/min/1.73m² (Scr < κ branch)', () {
        // Scr<κ: ratio=0.714; 0.714^(-0.241) ≈ 1.084; 0.9938^25 ≈ 0.8563; ×1.012
        // 142 × 1.084 × 1.0 × 0.8563 × 1.012 ≈ 133.7
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 0.5,
          ageYears: 25,
          sex: BiologicalSex.female,
          weightKg: 55.0,
        );
        expect(result.getRight().toNullable()!.ckdEpi2021, closeTo(133.7, 0.8));
      });

      test('result is rounded to 1 decimal place', () {
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.male,
          weightKg: 70.0,
        );
        final egfr = result.getRight().toNullable()!.ckdEpi2021;
        final decimals = egfr.toString().split('.').last.length;
        expect(decimals, lessThanOrEqualTo(1));
      });
    });

    // ── CKD staging ───────────────────────────────────────────────────────────

    group('CKD staging (KDIGO 2022)', () {
      CkdStage stage({
        required double scr,
        required int age,
        BiologicalSex sex = BiologicalSex.male,
      }) =>
          CalculatorEngine.calculateGfr(
            serumCreatinineMgDl: scr,
            ageYears: age,
            sex: sex,
            weightKg: 70.0,
          ).getRight().toNullable()!.ckdStage;

      test('G1 (eGFR ≥90): male 50 y Scr 1.0 → ≈91.7', () {
        expect(stage(scr: 1.0, age: 50), CkdStage.g1);
      });

      test('G2 (60–89): male 55 y Scr 1.2 → ≈71.4', () {
        // Scr/κ=1.333; 1.333^(-1.2)≈0.7079; 0.9938^55≈0.7104
        // 142 × 0.7079 × 0.7104 ≈ 71.4
        expect(stage(scr: 1.2, age: 55), CkdStage.g2);
      });

      test('G3a (45–59): male 65 y Scr 1.5 → ≈51.3', () {
        expect(stage(scr: 1.5, age: 65), CkdStage.g3a);
      });

      test('G3b (30–44): male 70 y Scr 2.0 → ≈35.2', () {
        // Scr/κ=2.222; 2.222^(-1.2)≈0.3834; 0.9938^70≈0.6471
        // 142 × 0.3834 × 0.6471 ≈ 35.2
        expect(stage(scr: 2.0, age: 70), CkdStage.g3b);
      });

      test('G4 (15–29): male 70 y Scr 4.0 → ≈15.3', () {
        // Scr/κ=4.444; 4.444^(-1.2)≈0.1666; 0.9938^70≈0.6471
        // 142 × 0.1666 × 0.6471 ≈ 15.3
        expect(stage(scr: 4.0, age: 70), CkdStage.g4);
      });

      test('G5 (eGFR <15): male 70 y Scr 8.0 → ≈6.7', () {
        // Scr/κ=8.889; 8.889^(-1.2)≈0.0727; 0.9938^70≈0.6471
        // 142 × 0.0727 × 0.6471 ≈ 6.7
        expect(stage(scr: 8.0, age: 70), CkdStage.g5);
      });

      test('G2 boundary — female 60 y Scr 1.0 → ≈64.6', () {
        // Uses sexFactor=1.012; verifies female branch in staging
        expect(stage(scr: 1.0, age: 60, sex: BiologicalSex.female), CkdStage.g2);
      });
    });
  });

  // ════════════════════════════════════════════════════════════════════════════
  // GFR — Cockcroft-Gault
  // ════════════════════════════════════════════════════════════════════════════

  group('CalculatorEngine.calculateGfr — Cockcroft-Gault', () {
    group('calculation accuracy', () {
      test('male, 50 y, 70 kg, Scr 1.0 → CrCl = 87.5 mL/min', () {
        // ((140-50) × 70) / (72 × 1.0) = 6300/72 = 87.5 (exact)
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.male,
          weightKg: 70.0,
        );
        expect(result.getRight().toNullable()!.cockcroftGault, closeTo(87.5, 0.01));
      });

      test('female, 50 y, 60 kg, Scr 1.0 → CrCl ≈ 63.8 mL/min', () {
        // exact = 75.0 × 0.85 = 63.75; after _round1: (63.75×10).round()/10 = 63.8
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.female,
          weightKg: 60.0,
        );
        expect(result.getRight().toNullable()!.cockcroftGault, closeTo(63.8, 0.05));
      });

      test('male, 40 y, 80 kg, Scr 1.0 → CrCl = 111.1 mL/min', () {
        // ((140-40) × 80) / (72 × 1.0) = 8000/72 = 111.111…
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 40,
          sex: BiologicalSex.male,
          weightKg: 80.0,
        );
        expect(result.getRight().toNullable()!.cockcroftGault, closeTo(111.1, 0.1));
      });

      test('male, 75 y, 65 kg, Scr 2.0 → CrCl = 29.3 mL/min', () {
        // ((140-75) × 65) / (72 × 2.0) = 4225/144 = 29.34…
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 2.0,
          ageYears: 75,
          sex: BiologicalSex.male,
          weightKg: 65.0,
        );
        expect(result.getRight().toNullable()!.cockcroftGault, closeTo(29.3, 0.1));
      });

      test('female, 60 y, 55 kg, Scr 1.2 → CrCl = 43.3 mL/min', () {
        // ((140-60) × 55) / (72 × 1.2) × 0.85 = 4400/86.4 × 0.85 ≈ 43.3
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.2,
          ageYears: 60,
          sex: BiologicalSex.female,
          weightKg: 55.0,
        );
        expect(result.getRight().toNullable()!.cockcroftGault, closeTo(43.3, 0.1));
      });

      test('0.85 sex factor is applied exactly once for female', () {
        // Both values are rounded to 1 dp before comparison, so tolerance
        // must absorb up to 0.05 of rounding error on each side → use 0.1.
        final male = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.male,
          weightKg: 70.0,
        ).getRight().toNullable()!.cockcroftGault;

        final female = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: 1.0,
          ageYears: 50,
          sex: BiologicalSex.female,
          weightKg: 70.0,
        ).getRight().toNullable()!.cockcroftGault;

        expect(female, closeTo(male * 0.85, 0.1));
      });
    });
  });

  // ════════════════════════════════════════════════════════════════════════════
  // GFR — Input validation
  // ════════════════════════════════════════════════════════════════════════════

  group('CalculatorEngine.calculateGfr — validation', () {
    GfrResult? ok({
      double scr = 1.0,
      int age = 50,
      BiologicalSex sex = BiologicalSex.male,
      double weight = 70.0,
    }) =>
        CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: scr,
          ageYears: age,
          sex: sex,
          weightKg: weight,
        ).getRight().toNullable();

    ValidationFailure? fail({
      double scr = 1.0,
      int age = 50,
      BiologicalSex sex = BiologicalSex.male,
      double weight = 70.0,
    }) =>
        CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: scr,
          ageYears: age,
          sex: sex,
          weightKg: weight,
        ).getLeft().toNullable();

    group('serum creatinine', () {
      test('rejects Scr below minimum (0.09)', () {
        expect(fail(scr: 0.09), isA<ValidationFailure>());
      });
      test('rejects Scr above maximum (30.1)', () {
        expect(fail(scr: 30.1), isA<ValidationFailure>());
      });
      test('rejects Scr = 0', () {
        expect(fail(scr: 0.0), isA<ValidationFailure>());
      });
      test('rejects Scr = double.nan', () {
        expect(fail(scr: double.nan), isA<ValidationFailure>());
      });
      test('rejects Scr = double.infinity', () {
        expect(fail(scr: double.infinity), isA<ValidationFailure>());
      });
      test('accepts minimum boundary Scr (0.1)', () {
        expect(ok(scr: 0.1), isNotNull);
      });
      test('accepts maximum boundary Scr (30.0)', () {
        expect(ok(scr: 30.0), isNotNull);
      });
    });

    group('age', () {
      test('rejects age = -1', () {
        expect(fail(age: -1), isA<ValidationFailure>());
      });
      test('rejects age above maximum (131)', () {
        expect(fail(age: 131), isA<ValidationFailure>());
      });
      test('accepts minimum boundary age (0)', () {
        expect(ok(age: 0), isNotNull);
      });
      test('accepts maximum boundary age (130)', () {
        expect(ok(age: 130), isNotNull);
      });
    });

    group('weight', () {
      test('rejects weight = 0', () {
        expect(fail(weight: 0.0), isA<ValidationFailure>());
      });
      test('rejects weight below minimum (0.4)', () {
        expect(fail(weight: 0.4), isA<ValidationFailure>());
      });
      test('rejects weight above maximum (500.1)', () {
        expect(fail(weight: 500.1), isA<ValidationFailure>());
      });
      test('rejects weight = double.nan', () {
        expect(fail(weight: double.nan), isA<ValidationFailure>());
      });
      test('accepts minimum boundary weight (0.5)', () {
        expect(ok(weight: 0.5), isNotNull);
      });
    });

    group('validation priority — first failing field is reported', () {
      test('Scr error is reported before age error', () {
        final result = CalculatorEngine.calculateGfr(
          serumCreatinineMgDl: -1.0, // invalid
          ageYears: 200,             // also invalid
          sex: BiologicalSex.male,
          weightKg: 70.0,
        );
        expect(result.isLeft(), isTrue);
        final msg = result.getLeft().toNullable()!.message.toLowerCase();
        expect(msg, contains('creatinine'));
      });
    });
  });

  // ════════════════════════════════════════════════════════════════════════════
  // Either contract
  // ════════════════════════════════════════════════════════════════════════════

  group('Either contract', () {
    test('valid BMI input always returns Right', () {
      final result = CalculatorEngine.calculateBmi(
        weightKg: 70.0,
        heightCm: 175.0,
      );
      expect(result, isA<Right<ValidationFailure, BmiResult>>());
    });

    test('invalid BMI input always returns Left<ValidationFailure>', () {
      final result = CalculatorEngine.calculateBmi(
        weightKg: -1.0,
        heightCm: 175.0,
      );
      expect(result, isA<Left<ValidationFailure, BmiResult>>());
    });

    test('valid GFR input always returns Right', () {
      final result = CalculatorEngine.calculateGfr(
        serumCreatinineMgDl: 1.0,
        ageYears: 50,
        sex: BiologicalSex.male,
        weightKg: 70.0,
      );
      expect(result, isA<Right<ValidationFailure, GfrResult>>());
    });

    test('invalid GFR input always returns Left<ValidationFailure>', () {
      final result = CalculatorEngine.calculateGfr(
        serumCreatinineMgDl: 0.0,
        ageYears: 50,
        sex: BiologicalSex.male,
        weightKg: 70.0,
      );
      expect(result, isA<Left<ValidationFailure, GfrResult>>());
    });
  });
}
