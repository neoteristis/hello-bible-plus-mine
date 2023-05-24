import 'package:equatable/equatable.dart';

class MessageByRole extends Equatable {
  final String? content;
  final Role? role;
  final DateTime? createdAt;

  const MessageByRole({
    this.content,
    this.role,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        content,
        role,
        createdAt,
      ];

  factory MessageByRole.fromMap(Map<String, dynamic> map) {
    return MessageByRole(
      content: map['content'] ?? '',
      role: map['role'] != null ? Role.fromString(map['role']) : null,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'])?.toLocal()
          : null,
    );
  }
}

enum Role {
  user,
  system,
  unkwon;

  factory Role.fromString(String role) {
    switch (role) {
      case 'user':
        return Role.user;
      case 'system':
        return Role.system;
      default:
        return Role.unkwon;
    }
  }
}
