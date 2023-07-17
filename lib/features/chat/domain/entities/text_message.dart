import 'package:equatable/equatable.dart';

import 'message_by_role.dart';

class TextMessage extends Equatable {
  final String? content;
  final DateTime? createdAt;
  final Role? role;

  const TextMessage({
    this.content,
    this.createdAt,
    this.role,
  });

  @override
  List<Object?> get props => [
        content,
        createdAt,
        role,
      ];
}
