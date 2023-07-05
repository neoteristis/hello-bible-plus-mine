import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/extension/time_of_day_extension.dart';

import '../../../../../l10n/function.dart';
import '../../../domain/entities/notif_by_category.dart';

part 'manage_notif_event.dart';
part 'manage_notif_state.dart';

class ManageNotifBloc extends Bloc<ManageNotifEvent, ManageNotifState> {
  ManageNotifBloc()
      : super(
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
        ),
      );
    }
  }
}
