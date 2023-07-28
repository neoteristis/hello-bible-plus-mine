import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../../../home/presentation/widgets/categories_by_section_widget.dart';

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
                  const Text(
                    'Une erreur s\'est produite',
                    style: TextStyle(color: ColorConstants.danger),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      context
                          .read<ChatBloc>()
                          .add(ChatCategoriesBySectionFetched());
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
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ChatBloc>().add(ChatCategoriesBySectionFetched());
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: state.categoriesBySection.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CategoriesBySectionWidget(
                          data: state.categoriesBySection[0],
                          index: index,
                        ),
                      ],
                    );
                  }
                  if (index == state.categoriesBySection.length - 1) {
                    return Column(
                      children: [
                        CategoriesBySectionWidget(
                          data: state.categoriesBySection[index],
                          index: index,
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }
                  return CategoriesBySectionWidget(
                    data: state.categoriesBySection[index],
                    index: index,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: const Divider(
        thickness: 1,
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final contentColor = Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202040).withOpacity(0.08),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .7,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      // fontSize: 12,
                      color: contentColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: contentColor,
                      fontSize: 12.sp,
                      // fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: contentColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
