import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmai/core/utils/calculator_engine.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

import 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(const CalculatorState());

  // Shadow fields let us update one calculator's result without wiping the other.
  BmiResult? _bmiResult;
  GfrResult? _gfrResult;
  String? _bmiError;
  String? _gfrError;

  void calculateBmi({required double weightKg, required double heightCm}) {
    CalculatorEngine.calculateBmi(
      weightKg: weightKg,
      heightCm: heightCm,
    ).fold(
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

  void reset() {
    _bmiResult = null;
    _gfrResult = null;
    _bmiError = null;
    _gfrError = null;
    emit(const CalculatorState());
  }

  void _emit() => emit(CalculatorState(
        bmiResult: _bmiResult,
        gfrResult: _gfrResult,
        bmiError: _bmiError,
        gfrError: _gfrError,
      ));
}
