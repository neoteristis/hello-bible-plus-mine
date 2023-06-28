part of 'contact_us_bloc.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();

  @override
  List<Object> get props => [];
}

class ContactUsFilePicked extends ContactUsEvent {}

class ContactUsFileRemoved extends ContactUsEvent {
  final PlatformFile file;
  const ContactUsFileRemoved(
    this.file,
  );
  @override
  List<Object> get props => [file];
}
