// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

//overriding the transform method in our ClientCoursesBloc is here an optimization to debounce
// the Events in order to prevent spamming our API unnecessarily.

//Note: Passing a transformer to on<AddListRideEvent> allows us
//to customize how events are processed.

EventTransformer<E> throttleDroppable<E>() {
  return (events, mapper) {
    return droppable<E>()
        .call(events.throttle(const Duration(milliseconds: 100)), mapper);
  };
}
