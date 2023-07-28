import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/features/home/presentation/widgets/categories_by_section_widget.dart';
import 'package:gpt/features/home/presentation/widgets/custom_home_app_bar.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/helper/log.dart';
import '../../../../core/helper/notifications.dart';
import '../../../../injections.dart';
import '../../../chat/domain/entities/entities.dart';
import '../../../chat/presentation/bloc/chat_bloc/chat_bloc.dart'
    hide ChatCategoriesBySectionFetched;
import '../../../chat/presentation/pages/chat_page.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Log.info(DateTime.now().timeZoneName);
    context.read<HomeBloc>().add(ChatCategoriesBySectionFetched());
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
        // Logger().w('this has been taped : $message');
        getIt<StreamController<String?>>(instanceName: 'select_nofitication')
            .add(message.data['theme']);
      },
    );
    _configureSelectNotificationSubject();
    _actOnNewNotificationComing();
  }

  void _actOnNewNotificationComing() {
    getIt<StreamController<RemoteMessage?>>(
            instanceName: 'new_push_notification')
        .stream
        .listen(
      (RemoteMessage? message) {
        if (message != null) {
          // Logger().w('a new notif coming : ${message.data}');
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
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      endDrawer: const CustomDrawer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CustomProgressIndicator(),
              );
            case Status.failed:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Une erreur s\'est produite',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChatCategoriesBySectionFetched());
                      },
                      icon: Icon(Icons.refresh_rounded,
                          color: Theme.of(context).primaryColor),
                      label: Text(
                        'Rafraichir',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              );
            case Status.loaded:
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<HomeBloc>()
                      .add(ChatCategoriesBySectionFetched());
                },
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categoriesBySection.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          CategoriesBySectionWidget(
                            data: state.categoriesBySection[0],
                            index: index,
                          ),
                        ],
                      );
                    }
                    if (index == state.categoriesBySection.length - 1) {
                      return Column(
                        children: [
                          CategoriesBySectionWidget(
                            data: state.categoriesBySection[index],
                            index: index,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    }
                    return CategoriesBySectionWidget(
                      data: state.categoriesBySection[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
