part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status,
    this.notifCats = const [],
    this.notifications = const [],
  });

  final Status? status;
  final List<NotifByCategory>? notifCats;
  final List<NotificationEntity>? notifications;

  @override
  List<Object?> get props => [
        status,
        notifCats,
        notifications,
      ];

  NotificationState copyWith({
    Status? status,
    List<NotifByCategory>? notifCats,
    List<NotificationEntity>? notifications,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifCats: notifCats ?? this.notifCats,
      notifications: notifications ?? this.notifications,
    );
  }
}

// const List<NotificationEntity> fakeNotifs = [
//   NotificationEntity(
//     type: NotifType.general,
//     title: 'Mise à jour',
//     content:
//         'Une mise à jour de l’application HelloBible+ est disponible. Mettez-la à jour en cliquant ici.',
//   ),
//   NotificationEntity(type: NotifType.),
//   NotificationEntity(),
// ];
