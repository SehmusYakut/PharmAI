import 'package:equatable/equatable.dart';

class ChatUsage extends Equatable {
  const ChatUsage({
    required this.userId,
    required this.queryCount,
    required this.isPremium,
  });

  final String userId;
  final int queryCount;
  final bool isPremium;

  @override
  List<Object> get props => [userId, queryCount, isPremium];
}
