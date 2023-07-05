part of 'manage_notif_bloc.dart';

class ManageNotifState extends Equatable {
  const ManageNotifState({
    this.notifByCategory = const [],
  });

  final List<NotifByCategory>? notifByCategory;

  @override
  List<Object?> get props => [
        notifByCategory,
      ];

  ManageNotifState copyWith({
    List<NotifByCategory>? notifByCategory,
  }) {
    return ManageNotifState(
      notifByCategory: notifByCategory ?? this.notifByCategory,
    );
  }
}

List<NotifByCategory> notifCats = const [
  NotifByCategory(
    id: '0',
    time: '08:00',
    title: 'Verset du jour',
    value: true,
    iconPath: 'assets/icons/verse_of_the_day.svg',
  ),
  NotifByCategory(
    id: '1',
    time: '10:00',
    title: 'Mot d\'encouragement',
    value: true,
    iconPath: 'assets/icons/subscription.svg',
  ),
];
