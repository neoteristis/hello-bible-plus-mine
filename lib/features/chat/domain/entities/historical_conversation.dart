import 'package:equatable/equatable.dart';

import '../../../../core/helper/log.dart';
import 'category.dart';
import 'message_by_role.dart';

class HistoricalConversation extends Equatable {
  final String? idString;
  final int? idInt;
  final Category? category;
  final String? user;
  final List<MessageByRole> messages;
  final String? title;
  final DateTime? createdAt;
  const HistoricalConversation({
    this.idString,
    this.idInt,
    this.category,
    this.user,
    required this.messages,
    this.title,
    this.createdAt,
  });
  @override
  List<Object?> get props => [
        idString,
        idInt,
        category,
        user,
        messages,
        title,
        createdAt,
      ];

  HistoricalConversation copyWith({
    String? idString,
    int? idInt,
    Category? category,
    String? user,
    List<MessageByRole>? messages,
    String? title,
    DateTime? createdAt,
  }) {
    return HistoricalConversation(
      idString: idString ?? this.idString,
      idInt: idInt ?? this.idInt,
      category: category ?? this.category,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory HistoricalConversation.fromJson(Map<String, dynamic> map) {
    // Log.info((map['messages'] as List).length);
    return HistoricalConversation(
      idString: map['_id'],
      category:
          map['category'] != null ? Category.fromJson(map['category']) : null,
      user: map['user'],
      title: map['title'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])?.toLocal()
          : null,
      messages: List<MessageByRole>.from(
        (map['messages'] as List).map((x) => MessageByRole.fromMap(x)).toList(),
      ),
    );
  }
}
