import 'package:equatable/equatable.dart';

class Drug extends Equatable {
  const Drug({
    required this.id,
    required this.barcode,
    required this.atcCode,
    required this.activeIngredient,
    required this.productName,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
    required this.description,
  });

  final int id;
  final String barcode;
  final String atcCode;
  final String activeIngredient;
  final String productName;
  final String category1;
  final String category2;
  final String category3;
  final String category4;
  final String category5;
  final String description;

  @override
  List<Object?> get props => [id];
}
