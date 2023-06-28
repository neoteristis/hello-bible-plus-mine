import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'contact_us_event.dart';
part 'contact_us_state.dart';

class ContactUsBloc extends Bloc<ContactUsEvent, ContactUsState> {
  ContactUsBloc() : super(const ContactUsState()) {
    on<ContactUsFilePicked>(_onContactUsFilePicked);
    on<ContactUsFileRemoved>(_onContactUsFileRemoved);
  }

  void _onContactUsFileRemoved(
    ContactUsFileRemoved event,
    Emitter<ContactUsState> emit,
  ) async {
    emit(
      state.copyWith(
        files: List.of(state.files!)
          ..removeWhere(
            (element) => element.name == event.file.name,
          ),
      ),
    );
  }

  void _onContactUsFilePicked(
    ContactUsFilePicked event,
    Emitter<ContactUsState> emit,
  ) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      final List<PlatformFile> files =
          result.files.map((file) => file).toList();
      emit(
        state.copyWith(
          files: List.of(state.files ?? [])..addAll(files),
        ),
      );

      for (final file in files) {
        print(file.name);
        print(file.bytes);
        print(file.size);
        print(file.extension);
        print(file.path);
      }
    } else {
      // User canceled the picker
    }
  }
}
