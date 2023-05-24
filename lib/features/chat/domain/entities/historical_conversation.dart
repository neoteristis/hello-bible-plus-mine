import 'package:equatable/equatable.dart';

import 'message_by_role.dart';

class HistoricalConversation extends Equatable {
  final String? idString;
  final int? idInt;
  final String? category;
  final String? user;
  final List<MessageByRole> messages;
  final String? title;
  const HistoricalConversation({
    this.idString,
    this.idInt,
    this.category,
    this.user,
    required this.messages,
    this.title,
  });
  @override
  List<Object?> get props => [
        idString,
        idInt,
        category,
        user,
        messages,
        title,
      ];

  HistoricalConversation copyWith({
    String? idString,
    int? idInt,
    String? category,
    String? user,
    List<MessageByRole>? messages,
    String? title,
  }) {
    return HistoricalConversation(
      idString: idString ?? this.idString,
      idInt: idInt ?? this.idInt,
      category: category ?? this.category,
      user: user ?? this.user,
      messages: messages ?? this.messages,
      title: title ?? this.title,
    );
  }

  factory HistoricalConversation.fromJson(Map<String, dynamic> map) {
    return HistoricalConversation(
      idString: map['_id'],
      category: map['category'],
      user: map['user'],
      title: map['title'],
      messages: List<MessageByRole>.from(
        (map['messages'] as List).map((x) => MessageByRole.fromMap(x)).toList(),
      ),
    );
  }
}
