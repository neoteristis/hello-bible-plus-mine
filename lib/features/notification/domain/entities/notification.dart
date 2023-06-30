import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? id;
  final NotifType? type;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final bool? isRead;

  const NotificationEntity({
    this.id,
    this.type,
    this.title,
    this.content,
    this.createdAt,
    this.isRead,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        content,
        createdAt,
        isRead,
      ];
}

enum NotifType {
  general,
  verse,
  word,
}
