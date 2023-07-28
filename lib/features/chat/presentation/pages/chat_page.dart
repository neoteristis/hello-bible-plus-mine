import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/features/home/presentation/page/home_page.dart';
import 'package:logger/logger.dart';

import 'package:gpt/core/helper/notifications.dart';

import '../../../../injections.dart';
import '../../domain/entities/category.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../widgets/chat/chat_body_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat';

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

    Stream<String> tokenStream;
    tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    tokenStream.listen(setToken);

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        Logger().w('this has been taped : $message');
        getIt<StreamController<String?>>(instanceName: 'select_nofitication')
            .add(message.data['theme']);
      },
    );
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
          Logger().w('a new notif coming : ${message.data}');
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
          {
            try {
              final json = jsonDecode(payload);
              final category = Category.fromJson(
                json,
              );

              context.go('/${HomePage.route}/${ChatPage.route}');
              context
                  .read<ChatBloc>()
                  .scaffoldKey
                  .currentState
                  ?.closeEndDrawer();
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Scaffold(
          key: context.read<ChatBloc>().scaffoldKey,
          resizeToAvoidBottomInset: true,
          appBar: const CustomAppBar(),
          endDrawer: const CustomDrawer(),
          body: BlocBuilder<ChatBloc, ChatState>(
            buildWhen: (previous, current) =>
            previous.conversationStatus != current.conversationStatus,
            builder: (context, state) {
              switch (state.conversationStatus) {
                case Status.loading:
                  return const Center(
                    child: CustomProgressIndicator(),
                  );
                case Status.loaded:
                  return const CustomChat();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
