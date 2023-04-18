import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/helper/unfocus_keyboard.dart';
import '../bloc/chat_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    this.isWhite,
  });

  final bool? isWhite;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          switch (state.catStatus) {
            case Status.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.brown[400],
                ),
              );
            case Status.failed:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.failure?.message ?? 'Une erreur s\'est produite',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context.read<ChatBloc>().add(ChatCategoriesFetched());
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
              return ListView.separated(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                physics: const BouncingScrollPhysics(),
                itemCount: state.categories!.length,
                separatorBuilder: (context, index) => Divider(
                  color: isWhite! ? Colors.brown[400] : Colors.white,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<ChatBloc>()
                          .scaffoldKey
                          .currentState
                          ?.closeDrawer();
                      unfocusKeyboard();
                      context.read<ChatBloc>().add(
                            ChatConversationChanged(
                              state.categories![index],
                            ),
                          );
                    },
                    splashColor: Theme.of(context).primaryColor,
                    highlightColor: Colors.black.withOpacity(.5),
                    child: ListTile(
                      splashColor: Theme.of(context).primaryColor,
                      title: Text(
                        state.categories?[index].name ?? 'Que dit la Bible ?',
                        style: TextStyle(
                          color: isWhite! ? Colors.brown[400] : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

final linearTertiaryAccentDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Colors.brown[400]!,
      Colors.brown[300]!,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
);
