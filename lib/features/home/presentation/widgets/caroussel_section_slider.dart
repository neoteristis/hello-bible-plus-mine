import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/helper/unfocus_keyboard.dart';
import 'package:gpt/features/chat/domain/entities/entities.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';

class CarousselSectionWidget extends StatelessWidget {
  const CarousselSectionWidget({
    super.key,
    required this.section,
  });

  final CategoriesBySection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: Text(
            section.sectionName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 17,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        CarouselSlider(
          items: section.categories
              ?.map((e) => CarousselItemWidget(
                    category: e,
                  ))
              .toList(),
          options: CarouselOptions(
            aspectRatio: 4 / 3,
            height: 100,
          ),
        )
      ],
    );
  }
}

class CarousselItemWidget extends StatelessWidget {
  const CarousselItemWidget({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        unfocusKeyboard();
        context.read<ChatBloc>().add(
              ChatConversationChanged(
                category: category,
              ),
            );
        context.go('/home/chat');
      },
      child: Container(
        width: size.width * 0.7,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.name ?? '',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                category.welcomePhrase ?? '',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.3,
                      fontSize: 13,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
