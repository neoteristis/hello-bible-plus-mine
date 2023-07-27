part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status,
    this.notifications = const [],
  });

  final Status? status;
  final List<NotificationEntity>? notifications;

  @override
  List<Object?> get props => [
        status,
        notifications,
      ];

  NotificationState copyWith({
    Status? status,
    List<NotificationEntity>? notifications,
  }) {
    return NotificationState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
    );
  }
}

List<NotificationEntity> fakeNotifs = [
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'Mise à jour',
    content:
        'Une mise à jour de l’application HelloBible+ est disponible. Mettez-la à jour en cliquant ici.',
    isRead: false,
    createdAt: DateTime.now().subtract(
      const Duration(minutes: 30),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'Parole du jour',
    content:
        '"Soyez toujours joyeux. Priez sans cesse. Rendez grâce en toutes circonstances, car c\'est à votre égard la volonté de Dieu en Jésus-Christ."- 1 Thessaloniciens 5:16-18',
    isRead: true,
    createdAt: DateTime.now().subtract(
      const Duration(minutes: 60),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'La Bible',
    content:
        'N’oubliez pas de consulter vos inspirations dans l’application aujourd’hui.',
    isRead: true,
    createdAt: DateTime.now().subtract(
      const Duration(minutes: 120),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'Mise à jour',
    content:
        'Une mise à jour de l’application HelloBible+ est disponible. Mettez-la à jour en cliquant ici.',
    isRead: false,
    createdAt: DateTime.now().subtract(
      const Duration(minutes: 30),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'Mise à jour',
    content:
        'Une mise à jour de l’application HelloBible+ est disponible. Mettez-la à jour en cliquant ici.',
    isRead: true,
    createdAt: DateTime.now().subtract(
      const Duration(days: 2),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'Parole du jour',
    content:
        '"Soyez toujours joyeux. Priez sans cesse. Rendez grâce en toutes circonstances, car c\'est à votre égard la volonté de Dieu en Jésus-Christ."- 1 Thessaloniciens 5:16-18',
    isRead: true,
    createdAt: DateTime.now().subtract(
      const Duration(days: 3),
    ),
  ),
  NotificationEntity(
    // logo: 'assets/icons/ichthys.svg',
    title: 'La Bible',
    content:
        'N’oubliez pas de consulter vos inspirations dans l’application aujourd’hui.',
    isRead: true,
    createdAt: DateTime.now().subtract(
      const Duration(days: 4),
    ),
  ),
];
