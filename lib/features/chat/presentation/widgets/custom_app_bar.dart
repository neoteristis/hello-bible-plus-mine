import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/constants/color_constants.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/widgets/logo_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(130.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).primaryColor,
      // elevation: 0,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.elliptical(MediaQuery.of(context).size.width, 56.0),
      //   ),
      // ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'assets/images/bible.webp',
          fit: BoxFit.cover,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return const LogoWidget();
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.conversation == null) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '👋  Bonjour ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.conversation?.category?.name ?? 'chargement...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              context.read<ChatBloc>().add(ChatConversationCleared());
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Transform.scale(
                scaleX: -1,
                child: SvgPicture.asset(
                  'assets/icons/icon_drawer.svg',
                  width: 25,
                  colorFilter: const ColorFilter.mode(
                      ColorConstants.secondary, BlendMode.srcIn),
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        )
      ],
    );
  }
}
