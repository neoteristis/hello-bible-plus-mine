import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/constants/status.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';

import '../../../../core/widgets/logo_widget.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/categories_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Center(
                  child: LogoWidget(size: 40),
                ),
              ),
            ),
            CategoriesWidget(
              isWhite: true,
            )
          ]),
        ),
      ),
    );
  }
}
