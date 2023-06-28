part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileStarted extends ProfileEvent {}

class ProfileUpdated extends ProfileEvent {}

class ProfileUpdateStarted extends ProfileEvent {}

class ProfilePicturePicked extends ProfileEvent {
  final ImageSource source;
  const ProfilePicturePicked({
    required this.source,
  });

  @override
  List<Object?> get props => [
        source,
      ];
}

class ProfilePictureUpdated extends ProfileEvent {
  final String? path;
  const ProfilePictureUpdated(
    this.path,
  );

  @override
  List<Object?> get props => [
        path,
      ];
}

class ProfileNameChanged extends ProfileEvent {
  final String name;
  const ProfileNameChanged(
    this.name,
  );

  @override
  List<Object?> get props => [
        name,
      ];
}

class ProfileEmailChanged extends ProfileEvent {
  final String email;
  const ProfileEmailChanged(
    this.email,
  );

  @override
  List<Object?> get props => [
        email,
      ];
}

class ProfilePhoneChanged extends ProfileEvent {
  final String phone;
  const ProfilePhoneChanged(
    this.phone,
  );

  @override
  List<Object?> get props => [
        phone,
      ];
}
