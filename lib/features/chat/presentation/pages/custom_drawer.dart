import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

import '../bloc/chat_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          child: Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Hello',
                    style: TextStyle(color: Colors.brown[400], fontSize: 40),
                  ),
                  TextSpan(
                    text: 'Bible',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[900],
                        fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              switch (state.catStatus) {
                case Status.loading:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.brown[400],
                    ),
                  );
                case Status.loaded:
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.categories?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.categories?[index].name ??
                              'Que dit la Bible ?'),
                          onTap: () {
                            context.read<ChatBloc>().add(
                                  ChatConversationChanged(
                                    state.categories![index],
                                  ),
                                );
                            unfocusKeyboard();
                          },
                        );
                      },
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        )
      ]),
    );
  }
}
