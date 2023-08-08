import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/core/theme/theme.dart';
import 'package:gpt/core/widgets/logo_with_text.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:gpt/features/chat/presentation/pages/chat_page.dart';
import 'package:gpt/features/container/pages/home/presentation/page/home_page.dart';

import '../../../../../chat/domain/entities/category.dart';
import '../bloc/home_bloc.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsets.only(
          left: 4.0,
        ),
        child: LogoWithText(
          logoColor: Colors.white,
          textColor: Colors.white,
          logoSize: Size(38, 38),
          textSize: 19,
          center: false,
        ),
      ),
      bottom: const SearchTextFieldAppBar(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      actions: [
        IconButton(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: SvgPicture.asset('assets/images/menu.svg'),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class SearchTextFieldAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const SearchTextFieldAppBar({super.key});

  @override
  State<SearchTextFieldAppBar> createState() => _SearchTextFieldAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(40.0);
}

class _SearchTextFieldAppBarState extends State<SearchTextFieldAppBar> {
  final TextEditingController controller = TextEditingController();

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
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.categoriesBySection != current.categoriesBySection,
      builder: (context, state) {
        Category? category;
        try {
          category = state.categoriesBySection
              .firstWhere((element) => element.id == '64ba9f74a8bccd0239a4b4e6')
              .categories
              ?.first;
        } catch (_) {}
        return Transform.translate(
          offset: const Offset(0, 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onSubmitted: (String value) {
                submit(category);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                hintText: category?.placeholder,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                suffixIcon: GestureDetector(
                  onTap: () => submit(category),
                  child: const Icon(
                    Icons.search,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void submit(Category? category) {
    if (category != null && controller.text.isNotEmpty) {
      unfocusKeyboard();
      context.go('/${HomePage.route}/${ChatPage.route}');
      context.read<ChatBloc>().add(
            ChatConversationChanged(
              category: category,
              firstMessage: controller.text,
            ),
          );
    }
  }
}
