import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/base_repository/base_repository.dart';
import 'package:gpt/core/constants/api_constants.dart';
import 'package:gpt/core/db_services/db_services.dart';
import 'package:gpt/core/helper/log.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:gpt/features/chat/presentation/pages/chat_page.dart';
import 'package:gpt/injections.dart';

import '../../features/container/pages/section/presentation/pages/section_page.dart';

Future setToken(String? token) async {
  final user = await getIt<DbService>().getUser();
  final id = user?.idString;
  if (id != null) {
    await getIt<BaseRepository>().patch(
      ApiConstants.registration(),
      body: {
        'deviceToken': token,
      },
    );
  }
}

void configureNotification(BuildContext context) {
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      if (message != null) {
        getIt<StreamController<String?>>(instanceName: 'select_nofitication')
            .add('message');
      }
    },
  );

  Stream<String> tokenStream;
  tokenStream = FirebaseMessaging.instance.onTokenRefresh;
  tokenStream.listen(setToken);

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      ///Logger().w('this has been taped : $message');
      getIt<StreamController<String?>>(instanceName: 'select_nofitication')
          .add(message.data['theme']);
    },
  );
  _configureSelectNotificationSubject(context);
  _actOnNewNotificationComing();
}

void _actOnNewNotificationComing() {
  getIt<StreamController<RemoteMessage?>>(instanceName: 'new_push_notification')
      .stream
      .listen(
    (RemoteMessage? message) {
      if (message != null) {
        ///Logger().w('a new notif coming : ${message.data}');
      }
    },
  );
}

void _configureSelectNotificationSubject(BuildContext context) {
  getIt<StreamController<String?>>(instanceName: 'select_nofitication')
      .stream
      .listen(
    (String? payload) {
      Log.debug(payload);
      if (payload != null) {
        {
          try {
            final json = jsonDecode(payload);
            final category = Category.fromJson(
              json,
            );
            context.go('/${SectionPage.route}/${ChatPage.route}');
            context.read<ChatBloc>().scaffoldKey.currentState?.closeEndDrawer();
            context.read<ChatBloc>().add(
                  ChatConversationChanged(
                    category: category,
                  ),
                );
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      }
    },
  );
}
