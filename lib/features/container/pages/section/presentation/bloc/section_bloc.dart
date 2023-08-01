import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/container/pages/section/domain/entities/welcome_theme.dart';

import '../../../../../../core/constants/status.dart';
import '../../domain/usecases/usecases.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final FetchWelcomeThemeUsecase fetchWelcomeTheme;
  // final GetResponseMessagesUsecase getResponseMessages;
  // late StreamSubscription<SseMessage> firstStreamSubscription;
  // late StreamSubscription<SseMessage> secondStreamSubscription;
  SectionBloc({
    required this.fetchWelcomeTheme,
    // required this.getResponseMessages,
  }) : super(const SectionState()) {
    on<SectionWelcomThemeFetched>(_onSectionWelcomThemeFetched);
    // on<SectionFirstMessageGot>(_onSectionFirstMessageGot);
  }

  void _onSectionWelcomThemeFetched(
    SectionWelcomThemeFetched event,
    Emitter<SectionState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    final res = await fetchWelcomeTheme(NoParams());
    res.fold(
      (l) => emit(
        state.copyWith(
          status: Status.failed,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            welcomeThemes: r,
            status: Status.loaded,
          ),
        );
        // for (final theme in r) {}
      },
    );
  }

  // void _onSectionFirstMessageGot(
  //   SectionFirstMessageGot event,
  //   Emitter<SectionState> emit,
  // ) async {
  //   final res = await getResponseMessages(
  //     PGetResponseMessage(
  //       idConversation: event.conversationId,
  //     ),
  //   );
  //   res.fold(
  //     (l) => emit(
  //       state.copyWith(),
  //     ),
  //     (rs) async {
  //       String messageJoined = '';
  //       print(rs.data);
  //       try {
  //         firstStreamSubscription = rs.data?.stream
  //             .transform(unit8Transformer)
  //             .transform(const Utf8Decoder())
  //             .transform(const LineSplitter())
  //             .transform(const SseTransformer())
  //             .listen(
  //           (SseMessage sse) async {
  //             String trunck = '';

  //             if (sse.data.length > 1) {
  //               trunck = sse.data.substring(1);
  //             } else if (sse.data == ' ') {
  //               if (messageJoined[messageJoined.length - 1]
  //                   .contains(RegExp(r'[?!;.,]'))) {
  //                 trunck = '\n\n';
  //               } else if (messageJoined
  //                   .split('.')
  //                   .last
  //                   .hasUnclosedParenthesis) {
  //                 trunck = ').\n\n';
  //               } else if (messageJoined.hasUnclosedQuote) {
  //                 trunck = '".\n\n';
  //               } else {
  //                 trunck = '.\n\n';
  //               }
  //             } else {
  //               trunck = sse.data;
  //             }
  //             if (trunck.contains(endMessageMarker)) {
  //               // mark that the stream is finished
  //             } else if (trunck != endMessageMarker) {}
  //           },
  //         );
  //       } catch (e) {
  //         emit(
  //           state.copyWith(),
  //         );
  //       }
  //     },
  //   );
  // }

  // Future getResponse(
  //   String conversationId,
  //   Emitter<SectionState> emit,
  //   WelcomeTheme theme,
  // ) async {
  //   final res = await getResponseMessages(PGetResponseMessage(
  //     idConversation: conversationId,
  //   ));

  //   res.fold(
  //     (l) => emit(
  //       state.copyWith(),
  //     ),
  //     (rs) async {
  //       String messageJoined = '';
  //       print(rs.data);
  //       try {
  //         firstStreamSubscription = rs.data?.stream
  //             .transform(unit8Transformer)
  //             .transform(const Utf8Decoder())
  //             .transform(const LineSplitter())
  //             .transform(const SseTransformer())
  //             .listen(
  //           (SseMessage sse) async {
  //             String trunck = '';

  //             if (sse.data.length > 1) {
  //               trunck = sse.data.substring(1);
  //             } else if (sse.data == ' ') {
  //               if (messageJoined[messageJoined.length - 1]
  //                   .contains(RegExp(r'[?!;.,]'))) {
  //                 trunck = '\n\n';
  //               } else if (messageJoined
  //                   .split('.')
  //                   .last
  //                   .hasUnclosedParenthesis) {
  //                 trunck = ').\n\n';
  //               } else if (messageJoined.hasUnclosedQuote) {
  //                 trunck = '".\n\n';
  //               } else {
  //                 trunck = '.\n\n';
  //               }
  //             } else {
  //               trunck = sse.data;
  //             }
  //             if (trunck.contains(endMessageMarker)) {
  //               // mark that the stream is finished
  //             } else if (trunck != endMessageMarker) {}
  //           },
  //         );
  //       } catch (e) {
  //         emit(
  //           state.copyWith(),
  //         );
  //       }
  //     },
  //   );
  // }

  // StreamTransformer<Uint8List, List<int>> unit8Transformer =
  //     StreamTransformer.fromHandlers(
  //   handleData: (data, sink) {
  //     sink.add(List<int>.from(data));
  //   },
  // );
}
