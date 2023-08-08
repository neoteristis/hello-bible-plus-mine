import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/features/chat/domain/entities/entities.dart';
import 'package:gpt/features/container/pages/home/presentation/widgets/custom_home_app_bar.dart';

import '../../../../../../core/constants/status.dart';
import '../../../../../../core/helper/unfocus_keyboard.dart';
import '../../../../../chat/domain/entities/category.dart';
import '../../../../../chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../../../../chat/presentation/pages/chat_page.dart';
import '../bloc/section_bloc.dart';

class SectionPage extends StatefulWidget {
  static const String route = 'section';

  const SectionPage({super.key});

  @override
  State<SectionPage> createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 2,
      ),
    );
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      endDrawer: const CustomDrawer(),
      body: BlocBuilder<SectionBloc, SectionState>(
        buildWhen: (previous, current) => previous.status != current.status,
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
                            .read<SectionBloc>()
                            .add(SectionWelcomThemeFetched());
                      },
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      label: Text(
                        'Rafraichir',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            case Status.loaded:
              return BlocBuilder<SectionBloc, SectionState>(
                buildWhen: (previous, current) =>
                    previous.welcomeThemes != current.welcomeThemes,
                builder: (context, state) {
                  final welcomeThemes = state.welcomeThemes;
                  if (welcomeThemes == null || welcomeThemes.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Vide',
                          // style: TextStyle(
                          //   color: Theme.of(context).colorScheme.error,
                          // ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            context
                                .read<SectionBloc>()
                                .add(SectionWelcomThemeFetched());
                          },
                          icon: Icon(
                            Icons.refresh_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: Text(
                            'Rafraichir',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10,
                      top: 30,
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context
                            .read<SectionBloc>()
                            .add(SectionWelcomThemeFetched());
                      },
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          ...welcomeThemes.map(
                            (e) {
                              final welcomeTheme = e;
                              final firstMessage = welcomeTheme.message;
                              return GestureDetector(
                                onTap: firstMessage != null
                                    ? () {
                                        context.read<ChatBloc>()
                                          ..add(ChatStreamCanceled())
                                          ..add(
                                            ChatConversationInited(
                                              welcomeTheme: welcomeTheme,
                                            ),
                                          );
                                        context.go(
                                          '/${SectionPage.route}/${ChatPage.route}?previousPage=${GoRouter.of(context).routerDelegate.currentConfiguration.fullPath.replaceAll('/', '')}',
                                        );
                                      }
                                    : null,
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.sizeOf(context).height * .20,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          welcomeTheme.category?.name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontSize: 23,
                                              ),
                                        ),
                                      ),
                                      if (firstMessage != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: Text(
                                            firstMessage,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                      if (firstMessage == null)
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 4.0,
                                                bottom: 4.0,
                                              ),
                                              child: Text(
                                                welcomeTheme.category
                                                        ?.welcomePhrase ??
                                                    '',
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 18.0,
                                              ),
                                              child: TextField(
                                                controller: controller,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiary,
                                                ),
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                decoration: InputDecoration(
                                                  hintMaxLines: 1,
                                                  filled: true,
                                                  fillColor: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.1),
                                                  // fillColor: Theme.of(context)
                                                  //     .colorScheme
                                                  //     .onPrimary,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  suffixIcon: GestureDetector(
                                                    onTap: () => submit(
                                                        welcomeTheme.category),
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  border: border,
                                                  enabledBorder: border,
                                                  focusedBorder: border,
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                  hintText: welcomeTheme
                                                      .category?.placeholder,
                                                ),
                                                onSubmitted: (_) {
                                                  submit(welcomeTheme.category);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void submit(Category? category) {
    if (controller.text.isNotEmpty) {
      unfocusKeyboard();
      if (category != null) {
        context.go('/${SectionPage.route}/${ChatPage.route}');
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category: category,
                firstMessage: controller.text,
              ),
            );
      }
    }
  }
}
