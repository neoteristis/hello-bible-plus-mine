import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/base_repository/base_repository.dart';
import 'package:gpt/core/constants/api_constants.dart';
import 'package:gpt/core/routes/route_name.dart';
import 'package:logger/logger.dart';
import '../../../../core/db_services/db_services.dart';
import '../../../../core/helper/log.dart';
import '../../../../injections.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_body.dart';
import '../widgets/container_categories_widget.dart';
import '../widgets/custom_app_bar.dart';
import 'custom_drawer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          getIt<StreamController<String?>>(instanceName: 'select_nofitication')
              .add('message');
        }
      },
    );
    context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());

    Stream<String> tokenStream;
    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(setToken);

    FirebaseMessaging.instance.subscribeToTopic('hello_bible_topic');

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Logger().w('this has been taped : $message');
      getIt<StreamController<String?>>(instanceName: 'select_nofitication')
          .add(message.messageId);
    });
    _configureSelectNotificationSubject();
    _actOnNewNotificationComing();
    super.initState();
  }

  void _actOnNewNotificationComing() {
    getIt<StreamController<RemoteMessage?>>(
            instanceName: 'new_push_notification')
        .stream
        .listen(
      (RemoteMessage? message) {
        if (message != null) {
          Logger().w('a new notif coming : $message');
        }
      },
    );
  }

  void _configureSelectNotificationSubject() {
    getIt<StreamController<String?>>(instanceName: 'select_nofitication')
        .stream
        .listen(
      (String? payload) {
        context.go(RouteName.historical);
        if (payload != null) {
          Logger().w('a new notif selected');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            key: context.read<ChatBloc>().scaffoldKey,
            appBar: const CustomAppBar(),
            drawer: const CustomDrawer(),
            body: state.conversation == null
                ? const ContainerCategoriesWidget()
                : const ChatBody(),
          );
        },
      ),
    );
  }
}

void setToken(String? token) async {
  Log.info(token);
  final user = await getIt<DbServiceImp>().getUser();
  final id = user?.idString;
  if (id != null) {
    await getIt<BaseRepository>().patch(
      '${ApiConstants.registration}/$id',
      body: {
        'deviceToken': token,
      },
    );
  }
}
