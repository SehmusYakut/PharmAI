import 'package:equatable/equatable.dart';

enum BookmarkItemType { drug, icd10 }

class Bookmark extends Equatable {
  const Bookmark({
    required this.id,
    required this.userId,
    required this.itemType,
    required this.itemId,
    required this.title,
    required this.subtitle,
    required this.savedAt,
  });

  final int id;
  final String userId;
  final BookmarkItemType itemType;
  final String itemId;
  final String title;
  final String subtitle;
  final DateTime savedAt;

  @override
  List<Object> get props => [
    id,
    userId,
    itemType,
    itemId,
    title,
    subtitle,
    savedAt,
  ];
}
