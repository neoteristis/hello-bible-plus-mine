import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
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
    context.read<ChatBloc>().add(ChatCategoriesFetched());

    Stream<String> tokenStream;
    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(setToken);
    FirebaseMessaging.instance.getToken().then((value) => Log.info(value));

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) => showFlutterNotification,
        );

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
  // await getIt<Dio>().post('api/user/token-firebase', data: {
  //   'token_firebase': token,
  // });
}
