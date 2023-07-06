import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/status.dart';
import '../../domain/entities/notif_by_category.dart';
import '../../domain/entities/notification_entity.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationState(notifications: fakeNotifs)) {}
}
