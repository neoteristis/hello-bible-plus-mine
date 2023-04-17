import 'package:equatable/equatable.dart';

import 'conversation.dart';

class Message extends Equatable {
  const Message({
    this.id,
    this.content,
    this.conversation,
    this.response,
    this.created,
    this.updated,
  });

  final int? id;
  final String? content;
  final Conversation? conversation;
  final String? response;
  final String? created;
  final String? updated;

  Message copyWith({
    int? id,
    String? content,
    Conversation? conversation,
    String? response,
    String? created,
    String? updated,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      conversation: conversation ?? this.conversation,
      response: response ?? this.response,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      content: json["content"],
      conversation: json["conversation"] == null
          ? null
          : Conversation.fromJson(json["conversation"]),
      response: json["response"],
      created: json["created"],
      updated: json["updated"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "conversation": conversation?.toJson(),
        "response": response,
        "created": created,
        "updated": updated,
      };

  @override
  List<Object?> get props => [
        id,
        content,
        conversation,
        response,
        created,
        updated,
      ];
}
