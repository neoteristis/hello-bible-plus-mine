part of 'contact_us_bloc.dart';

class ContactUsState extends Equatable {
  const ContactUsState({
    this.files = const [],
  });

  final List<PlatformFile>? files;

  @override
  List<Object?> get props => [files];

  ContactUsState copyWith({
    List<PlatformFile>? files,
  }) {
    return ContactUsState(
      files: files ?? this.files,
    );
  }
}
