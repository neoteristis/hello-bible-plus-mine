import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'categories_by_section_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        switch (state.catStatus) {
          case Status.loading:
            return const Center(
              child: CustomProgressIndicator(),
            );
          case Status.failed:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Une erreur s\'est produite',
                    style: TextStyle(color: ColorConstants.danger),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(ChatCategoriesBySectionFetched());
                    },
                    icon: Icon(Icons.refresh_rounded,
                        color: Theme.of(context).primaryColor),
                    label: Text(
                      'Rafraichir',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
                ],
              ),
            );
          case Status.loaded:
            final hintColor = Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(isLight(context) ? 1 : .7);
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: state.categoriesBySection.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            controller: searchController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Theme.of(context).primaryColor,
                            onSubmitted: (value) {
                              try {
                                //TODO section id here
                                final category = state.categoriesBySection
                                    .firstWhere((element) =>
                                        element.id ==
                                        '64ba9f74a8bccd0239a4b4e6')
                                    .categories
                                    ?.first;
                                context
                                    .read<ChatBloc>()
                                    .scaffoldKey
                                    .currentState
                                    ?.closeDrawer();
                                unfocusKeyboard();
                                if (category != null) {
                                  context.read<ChatBloc>().add(
                                        ChatConversationChanged(
                                          category: category,
                                          firstMessage: searchController.text,
                                        ),
                                      );
                                }
                                print(searchController.text);
                              } catch (_) {
                                print(_);
                              }
                            },
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: IconButton(
                                onPressed: () {
                                  try {
                                    //TODO section id here
                                    final category = state.categoriesBySection
                                        .firstWhere((element) =>
                                            element.id ==
                                            '64ba9f74a8bccd0239a4b4e6')
                                        .categories
                                        ?.first;
                                    context
                                        .read<ChatBloc>()
                                        .scaffoldKey
                                        .currentState
                                        ?.closeDrawer();
                                    unfocusKeyboard();
                                    if (category != null) {
                                      context.read<ChatBloc>().add(
                                            ChatConversationChanged(
                                              category: category,
                                              firstMessage:
                                                  searchController.text,
                                            ),
                                          );
                                    }
                                    print(searchController.text);
                                  } catch (_) {
                                    print(_);
                                  }
                                },
                                icon: Icon(
                                  Icons.search,
                                  color: hintColor,
                                ),
                              ),
                              hintText: 'Chercher dans la Bible',
                              // AppLocalizations.of(context)!.searchInBible,
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                // fontSize: 14,
                                color: hintColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CategoriesBySectionWidget(
                          data: state.categoriesBySection[0],
                          index: index,
                        ),
                      ],
                    );
                  } else if (index == state.categoriesBySection.length - 1) {
                    return Column(
                      children: [
                        CategoriesBySectionWidget(
                          data: state.categoriesBySection[index],
                          index: index,
                        ),
                        const CustomDivider(),
                        SizedBox(
                          height: 90,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                              BottomContainer(
                                title: 'Comment utiliser cet outil ?',
                                subtitle: 'HelloBible+ se base sur la nouve...',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              BottomContainer(
                                title: ' ⚡ Payez selon votre usage',
                                subtitle: 'Aucune obligation de montant,...',
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  }
                  return CategoriesBySectionWidget(
                    data: state.categoriesBySection[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => const CustomDivider(),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: const Divider(
        thickness: 1,
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final contentColor = Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202040).withOpacity(0.08),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      // fontSize: 12,
                      color: contentColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: contentColor,
                      fontSize: 12.sp,
                      // fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: contentColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
