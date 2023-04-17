import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';

import '../../../../core/widgets/logo_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(130.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(MediaQuery.of(context).size.width, 56.0),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return LogoWidget();
          // }
          // return Text(
          //   state.conversation!.category!.name ?? 'Hello',
          //   style: TextStyle(color: Colors.white, fontSize: 20),
          // );
        },
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state.conversation == null) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '👋  Bonjour ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w200),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                state.conversation!.category!.name ?? 'Hello',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
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
            icon: Icon(
              Icons.add,
              color: Colors.white,
            )),
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
                size: 30,
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
