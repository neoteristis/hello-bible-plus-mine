part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status,
    this.notifCats = const [],
  });

  final Status? status;
  final List<NotifByCategory>? notifCats;

  @override
  List<Object?> get props => [
        status,
        notifCats,
      ];

  NotificationState copyWith({
    Status? status,
    List<NotifByCategory>? notifCats,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifCats: notifCats ?? this.notifCats,
    );
  }
}
