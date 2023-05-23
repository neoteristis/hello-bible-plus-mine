import 'package:equatable/equatable.dart';

import 'category.dart';

class Conversation extends Equatable {
  const Conversation({
    this.id,
    this.title,
    this.category,
    this.created,
    this.updated,
  });

  final String? id;
  final String? title;
  final Category? category;
  final String? created;
  final String? updated;

  Conversation copyWith({
    String? id,
    String? title,
    Category? category,
    String? created,
    String? updated,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      title: json['title'],
      category:
          json['category'] == null ? null : Category.fromJson(json['category']),
      created: json['created'],
      updated: json['updated'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'category': category?.toJson(),
        'created': created,
        'updated': updated,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        created,
        updated,
      ];
}
