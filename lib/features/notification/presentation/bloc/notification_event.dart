part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationValuesByCategoryGotten extends NotificationEvent {}

class NotificationValueSwitched extends NotificationEvent {
  final NotificationTime notif;
  const NotificationValueSwitched(
    this.notif,
  );

  @override
  List<Object> get props => [notif];
}

class NotificationTimeSelected extends NotificationEvent {
  final BuildContext context;
  const NotificationTimeSelected({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}
