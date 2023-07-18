import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/routes/route_name.dart';
import 'package:gpt/core/widgets/logo.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../bloc/historical_bloc/historical_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.elevation,
  }) : super(key: key);

  final double? elevation;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.conversation != current.conversation,
      builder: (context, state) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: elevation ?? 11,
          titleSpacing: 0,
          shadowColor: Colors.black.withOpacity(0.4),
          leading: state.conversation != null
              ? IconButton(
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    unfocusKeyboard();

                    if (state.readOnly!) {
                      context.go(RouteName.historical);
                    } else {
                      context
                          .read<HistoricalBloc>()
                          .add(const HistoricalFetched(isRefresh: true));
                    }
                    context.read<ChatBloc>().add(ChatConversationCleared());
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                )
              : null,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.tertiary),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              // return const LogoWidget();
              if (state.conversation == null) {
                return const Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: LogoWithText(
                    logoSize: Size(24, 24),
                    textSize: 17.55,
                    center: false,
                  ),
                );
              }
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
                          state.conversation!.category?.name ??
                              AppLocalizations.of(context)!.loading,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            // fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          state.conversation!.category?.welcomePhrase ?? '',
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                            // fontSize: 11,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                // leading: const Logo(
                //   size: Size(22, 22),
                // ),
                // title: Text(
                //   state.conversation!.category?.name ?? 'chargement ...',
                //   style: TextStyle(
                //     fontWeight: FontWeight.w500,
                //     fontSize: 14.sp,
                //     color: Theme.of(context).colorScheme.tertiary,
                //   ),
                // ),
                // subtitle: Text(
                //   state.conversation!.category?.welcomePhrase ?? '',
                //   softWrap: false,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //     fontWeight: FontWeight.w400,
                //     fontSize: 10.sp,
                //     color: Theme.of(context).colorScheme.tertiary,
                //   ),
                // ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                // context.read<ChatBloc>().scaffoldKey.currentState.openEndDrawer();
                if (context
                    .read<ChatBloc>()
                    .scaffoldKey
                    .currentState!
                    .isEndDrawerOpen) {
                  // Scaffold.of(context).closeEndDrawer();
                  context
                      .read<ChatBloc>()
                      .scaffoldKey
                      .currentState
                      ?.closeEndDrawer();
                } else {
                  Scaffold.of(context).openEndDrawer();
                }
                // getIt<DbService>().deleteToken();
                // getIt<DbService>().deleteUser();
              },
              icon: Visibility(
                visible: state.conversation == null,
                replacement: IconButton(
                    icon: const Icon(Icons.more_vert), onPressed: () {}),
                child: SvgPicture.asset(
                  'assets/icons/more_vert.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    context
                            .read<ChatBloc>()
                            .scaffoldKey
                            .currentState!
                            .isEndDrawerOpen
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.tertiary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            // Builder(
            //   builder: (BuildContext context) {
            //     return IconButton(
            //       icon: Transform.scale(
            //         scaleX: -1,
            //         child: ,
            //       ),
            //       onPressed: () {
            //         // Scaffold.of(context).openDrawer();
            //         context.read<AuthBloc>().add(AuthLogoutSubmitted());
            //       },
            //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            //     );
            //   },
            // )
          ],
        );
      },
    );
  }
}
