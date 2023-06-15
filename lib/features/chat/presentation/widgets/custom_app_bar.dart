import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gpt/core/constants/color_constants.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../../../../core/widgets/logo_widget.dart';
import '../bloc/historical_bloc/historical_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 11,
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
      iconTheme: IconThemeData(color: Colors.black),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          // return const LogoWidget();
          return const LogoWithText(
            logoSize: Size(24, 24),
            textSize: 17.55,
            center: false,
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            // context.read<HistoricalBloc>().add(HistoricalFetched());
            // context.read<ChatBloc>().add(ChatConversationCleared());
          },
          icon: SvgPicture.asset(
            'assets/icons/more_vert.svg',
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
  }
}
