import 'package:equatable/equatable.dart';
import 'package:pharmai/core/utils/calculator_models.dart';

class CalculatorState extends Equatable {
  const CalculatorState({
    this.bmiResult,
    this.gfrResult,
    this.pediatricWeightResult,
    this.ivDripRateResult,
    this.bmiError,
    this.gfrError,
    this.pediatricWeightError,
    this.ivDripRateError,
  });

  final BmiResult? bmiResult;
  final GfrResult? gfrResult;
  final PediatricWeightResult? pediatricWeightResult;
  final IvDripRateResult? ivDripRateResult;
  final String? bmiError;
  final String? gfrError;
  final String? pediatricWeightError;
  final String? ivDripRateError;

  @override
  List<Object?> get props => [
    bmiResult,
    gfrResult,
    pediatricWeightResult,
    ivDripRateResult,
    bmiError,
    gfrError,
    pediatricWeightError,
    ivDripRateError,
  ];
}
