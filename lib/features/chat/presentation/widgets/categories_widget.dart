import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc.dart';
import 'categories_by_section_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    state.failure?.message ?? 'Une erreur s\'est produite',
                    style: const TextStyle(color: ColorConstants.danger),
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
            return Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: state.categoriesBySection.length,
                itemBuilder: (context, index) {
                  return CategoriesBySectionWidget(
                    data: state.categoriesBySection[index],
                  );
                },
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
