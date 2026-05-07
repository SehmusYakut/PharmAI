import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  const Bookmark({
    required this.code,
    required this.category,
    required this.savedAt,
  });

  final String code;
  final String category;
  final DateTime savedAt;

  @override
  List<Object> get props => [code, category, savedAt];
}
