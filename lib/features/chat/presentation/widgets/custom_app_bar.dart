import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/widgets/logo.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) =>
          previous.conversation != current.conversation,
      builder: (context, state) {
        return AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 11,
          titleSpacing: 0,
          shadowColor: Colors.black.withOpacity(0.4),
          // elevation: 0,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.vertical(
          //     bottom: Radius.elliptical(MediaQuery.of(context).size.width, 56.0),
          //   ),
          // ),
          // flexibleSpace: FlexibleSpaceBar(
          //   background: Image.asset(
          //     'assets/images/bible.webp',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          leading: Visibility(
            child: IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.all(0),
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              // return const LogoWidget();
              if (state.conversation == null) {
                return const LogoWithText(
                  logoSize: Size(24, 24),
                  textSize: 17.55,
                  center: false,
                );
              }
              return ListTile(
                minVerticalPadding: 40,
                visualDensity: VisualDensity(horizontal: 0, vertical: 0),
                contentPadding: EdgeInsets.zero,
                leading: const Logo(
                  size: Size(22, 22),
                ),
                title: Text(
                  state.conversation!.category?.name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(
                      0xFF111827,
                    ),
                  ),
                ),
                subtitle: Text(
                  state.conversation!.category?.welcomePhrase ?? '',
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Color(
                      0xFF111827,
                    ),
                  ),
                ),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                // context.read<HistoricalBloc>().add(HistoricalFetched());
                // context.read<ChatBloc>().add(ChatConversationCleared());
              },
              icon: Visibility(
                visible: state.conversation == null,
                replacement: const Icon(Icons.more_vert),
                child: SvgPicture.asset(
                  'assets/icons/more_vert.svg',
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
