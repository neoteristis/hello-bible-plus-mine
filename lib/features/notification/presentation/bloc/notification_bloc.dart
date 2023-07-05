import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/notification/domain/usecases/switch_notification_value_usecase.dart';

import '../../../../core/constants/status.dart';
import '../../domain/entities/notif_by_category.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/fetch_notification_values_by_category_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FetchNotificationValuesByCatecoryUsecase fetchNotifCategory;
  final SwitchNotificationValueUsecase switchNotification;
  NotificationBloc({
    required this.fetchNotifCategory,
    required this.switchNotification,
  }) : super(const NotificationState()) {
    on<NotificationValuesByCategoryGotten>(
        _onNotificationValuesByCategoryGotten);
  }

  void _onNotificationValuesByCategoryGotten(
    NotificationValuesByCategoryGotten event,
    Emitter<NotificationState> emit,
  ) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    final res = await fetchNotifCategory(NoParams());
    return res.fold(
        (l) => emit(
              state.copyWith(
                status: Status.failed,
              ),
            ), (notifCats) {
      emit(
        state.copyWith(
          status: Status.loaded,
          notifCats: notifCats,
        ),
      );
    });
  }
}
