part of 'manage_notif_bloc.dart';

class ManageNotifState extends Equatable {
  const ManageNotifState({
    this.notifByCategory = const [],
    this.configureNotifStatus = Status.init,
    this.notifCategoryStatus = Status.init,
  });

  final List<NotificationTime>? notifByCategory;
  final Status? configureNotifStatus;
  final Status? notifCategoryStatus;

  @override
  List<Object?> get props => [
        notifByCategory,
        configureNotifStatus,
        notifCategoryStatus,
      ];

  ManageNotifState copyWith({
    List<NotificationTime>? notifByCategory,
    Status? configureNotifStatus,
    Status? notifCategoryStatus,
  }) {
    return ManageNotifState(
      notifByCategory: notifByCategory ?? this.notifByCategory,
      configureNotifStatus: configureNotifStatus ?? this.configureNotifStatus,
      notifCategoryStatus: notifCategoryStatus ?? this.notifCategoryStatus,
    );
  }
}
