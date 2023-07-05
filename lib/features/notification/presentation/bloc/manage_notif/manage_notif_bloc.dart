import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/extension/time_of_day_extension.dart';

import '../../../../../core/constants/status.dart';
import '../../../../../l10n/function.dart';
import '../../../domain/entities/notif_by_category.dart';
import '../../../domain/usecases/usecases.dart';

part 'manage_notif_event.dart';
part 'manage_notif_state.dart';

class ManageNotifBloc extends Bloc<ManageNotifEvent, ManageNotifState> {
  final SwitchNotificationValueUsecase switchNotifValue;
  final ChangeNotifTimeUsecase changeNotifTime;
  ManageNotifBloc({
    required this.switchNotifValue,
    required this.changeNotifTime,
  }) : super(
          ManageNotifState(
            notifByCategory: notifCats,
          ),
        ) {
    on<ManageNotifTimeChanged>(_onManageNotifTimeChanged);
  }

  void _onManageNotifTimeChanged(
    ManageNotifTimeChanged event,
    Emitter<ManageNotifState> emit,
  ) async {
    final context = event.context;
    final heure = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      cancelText: dict(context).cancel,
      hourLabelText: dict(context).hour,
      helpText: dict(context).chooseHour,
    );
    if (heure != null) {
      final notifs = state.notifByCategory;
      final index = notifs?.indexWhere((element) => element.id == event.id);
      emit(
        state.copyWith(
          notifByCategory: List.of(state.notifByCategory!)
            ..removeAt(index!)
            ..insert(
              index,
              state.notifByCategory![index].copyWith(
                time: heure.toFormattedString(),
              ),
            ),
          configureNotifStatus: Status.loading,
        ),
      );
      final res = await changeNotifTime(
        state.notifByCategory![index],
      );
      return res.fold(
        (l) => emit(
          state.copyWith(
            configureNotifStatus: Status.failed,
          ),
        ),
        (r) => emit(
          state.copyWith(
            configureNotifStatus: Status.loaded,
          ),
        ),
      );
    }
  }
}
