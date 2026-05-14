import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/utils/calculator_engine.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  // Shadow fields let us update one calculator's result without wiping the other.
  BmiResult? _bmiResult;
  GfrResult? _gfrResult;
  PediatricWeightResult? _pediatricWeightResult;
  IvDripRateResult? _ivDripRateResult;
  String? _bmiError;
  String? _gfrError;
  String? _pediatricWeightError;
  String? _ivDripRateError;

  void calculateBmi({required double weightKg, required double heightCm}) {
    CalculatorEngine.calculateBmi(weightKg: weightKg, heightCm: heightCm).fold(
      (f) {
        _bmiResult = null;
        _bmiError = f.message;
      },
      (r) {
        _bmiResult = r;
        _bmiError = null;
      },
    );
    _emit();
  }

  void calculateGfr({
    required double serumCreatinineMgDl,
    required int ageYears,
    required BiologicalSex sex,
    required double weightKg,
  }) {
    CalculatorEngine.calculateGfr(
      serumCreatinineMgDl: serumCreatinineMgDl,
      ageYears: ageYears,
      sex: sex,
      weightKg: weightKg,
    ).fold(
      (f) {
        _gfrResult = null;
        _gfrError = f.message;
      },
      (r) {
        _gfrResult = r;
        _gfrError = null;
      },
    );
    _emit();
  }

  void calculatePediatricEstimatedWeight({
    required int ageValue,
    required PediatricAgeUnit ageUnit,
  }) {
    CalculatorEngine.calculatePediatricEstimatedWeight(
      ageValue: ageValue,
      ageUnit: ageUnit,
    ).fold(
      (f) {
        _pediatricWeightResult = null;
        _pediatricWeightError = f.message;
      },
      (r) {
        _pediatricWeightResult = r;
        _pediatricWeightError = null;
      },
    );
    _emit();
  }

  void calculateIvDripRate({
    required double volumeMl,
    required int totalTime,
    required IvTimeUnit timeUnit,
    required int dropFactor,
  }) {
    CalculatorEngine.calculateIvDripRate(
      volumeMl: volumeMl,
      totalTime: totalTime,
      timeUnit: timeUnit,
      dropFactor: dropFactor,
    ).fold(
      (f) {
        _ivDripRateResult = null;
        _ivDripRateError = f.message;
      },
      (r) {
        _ivDripRateResult = r;
        _ivDripRateError = null;
      },
    );
    _emit();
  }

  void reset() {
    _bmiResult = null;
    _gfrResult = null;
    _pediatricWeightResult = null;
    _ivDripRateResult = null;
    _bmiError = null;
    _gfrError = null;
    _pediatricWeightError = null;
    _ivDripRateError = null;
    emit(const CalculatorState());
  }

  void _emit() => emit(
    CalculatorState(
      bmiResult: _bmiResult,
      gfrResult: _gfrResult,
      pediatricWeightResult: _pediatricWeightResult,
      ivDripRateResult: _ivDripRateResult,
      bmiError: _bmiError,
      gfrError: _gfrError,
      pediatricWeightError: _pediatricWeightError,
      ivDripRateError: _ivDripRateError,
    ),
  );
}
