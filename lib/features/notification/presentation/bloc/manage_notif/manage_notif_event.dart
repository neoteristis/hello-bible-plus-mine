part of 'manage_notif_bloc.dart';

abstract class ManageNotifEvent extends Equatable {
  const ManageNotifEvent();

  @override
  List<Object> get props => [];
}

class ManageNotifCategoryFetched extends ManageNotifEvent {}

class ManageNotifTimeChanged extends ManageNotifEvent {
  // final String heure;
  final String id;
  final BuildContext context;
  const ManageNotifTimeChanged({
    // required this.heure,
    required this.id,
    required this.context,
  });

  @override
  List<Object> get props => [
        id,
        // heure,
        context,
      ];
}
