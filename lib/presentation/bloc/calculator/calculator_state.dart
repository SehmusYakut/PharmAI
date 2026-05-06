import 'package:equatable/equatable.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

class CalculatorState extends Equatable {
  const CalculatorState({
    this.bmiResult,
    this.gfrResult,
    this.bmiError,
    this.gfrError,
  });

  final BmiResult? bmiResult;
  final GfrResult? gfrResult;
  final String? bmiError;
  final String? gfrError;

  @override
  List<Object?> get props => [bmiResult, gfrResult, bmiError, gfrError];
}
