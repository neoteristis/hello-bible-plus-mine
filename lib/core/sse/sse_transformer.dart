import 'dart:async';

import 'sse_event_sink.dart';
import 'sse_message.dart';

class SseTransformer extends StreamTransformerBase<String, SseMessage> {
  const SseTransformer();
  @override
  Stream<SseMessage> bind(Stream<String> stream) {
    return Stream.eventTransformed(stream, (sink) => SseEventSink(sink));
  }
}
