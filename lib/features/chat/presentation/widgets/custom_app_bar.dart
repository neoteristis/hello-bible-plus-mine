import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/extension/string_extension.dart';
import 'package:gpt/core/widgets/logo.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gpt/features/chat/presentation/pages/historical_page.dart';
import 'package:gpt/features/home/presentation/page/home_page.dart';
import 'package:gpt/splash_screen.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../../../../l10n/function.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.conversation != current.conversation ||
          previous.chatToShare != current.chatToShare,
      builder: (context, state) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          shadowColor: Colors.black.withOpacity(0.4),
          leading: IconButton(
            constraints: const BoxConstraints(),
            padding: const EdgeInsets.all(0),
            onPressed: () {
              unfocusKeyboard();
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Row(
                children: [
                  const Logo(
                    size: Size(22, 22),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (state.conversation!.category?.name ??
                                  dict(context).loading)
                              .removeBackSlashN,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          (state.conversation!.category?.welcomePhrase ?? '')
                              .removeBackSlashN,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (context
                    .read<ChatBloc>()
                    .scaffoldKey
                    .currentState!
                    .isEndDrawerOpen) {
                  context
                      .read<ChatBloc>()
                      .scaffoldKey
                      .currentState
                      ?.closeEndDrawer();
                } else {
                  Scaffold.of(context).openEndDrawer();
                }
              },
              icon: PopupMenuButton<int>(
                position: PopupMenuPosition.under,
                surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                color: Theme.of(context).scaffoldBackgroundColor,
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onSelected: (int item) async {
                  switch (item) {
                    case 0:
                      final category = state.conversation?.category;
                      if (category != null) {
                        context.read<ChatBloc>().add(
                              ChatConversationChanged(category: category),
                            );
                      }
                      break;
                    case 1:
                      context.go(
                          '${SplashScreen.route}${HomePage.route}/${HistoricalPage.route}');
                      break;
                    case 2:
                      await Share.share(
                        state.chatToShare ?? '',
                      );
                      break;
                    default:
                  }
                },
                itemBuilder: (BuildContext context) {
                  final list = <PopupMenuEntry<int>>[];
                  list.add(
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nouvelle conversation'),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                  );
                  list.add(
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Historique'),
                          Icon(Icons.history_rounded),
                        ],
                      ),
                    ),
                  );
                  list.add(
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Partager'),
                          Icon(Icons.share),
                        ],
                      ),
                    ),
                  );
                  return list;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
