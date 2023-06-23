part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.user,
    this.status,
  });

  final User? user;
  final Status? status;

  @override
  List<Object?> get props => [
        user,
        status,
      ];

  ProfileState copyWith({
    User? user,
    Status? status,
  }) {
    return ProfileState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}
