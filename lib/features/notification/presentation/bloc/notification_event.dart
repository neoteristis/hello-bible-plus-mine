part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationValuesByCategoryGotten extends NotificationEvent {}

class NotificationValueSwitched extends NotificationEvent {
  final NotifByCategory notif;
  const NotificationValueSwitched(
    this.notif,
  );

  @override
  List<Object> get props => [notif];
}
