import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? id;
  // final NotifType? type;
  final String? title;
  final String? content;
  final DateTime? createdAt;
  final bool? isRead;
  final String? logo;

  const NotificationEntity({
    this.id,
    // this.type,
    this.title,
    this.content,
    this.createdAt,
    this.isRead,
    this.logo,
  });

  @override
  List<Object?> get props => [
        id,
        // type,
        title,
        content,
        createdAt,
        isRead,
        logo,
      ];

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createdAt,
    bool? isRead,
    String? logo,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      logo: logo ?? this.logo,
    );
  }
}

// enum NotifType {
//   general,
//   verse,
//   word,
// }
