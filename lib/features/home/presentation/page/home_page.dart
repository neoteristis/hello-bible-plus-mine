import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:gpt/features/chat/presentation/widgets/categories_by_section_widget.dart';
import 'package:gpt/features/chat/presentation/widgets/custom_home_app_bar.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
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
        },
      ),
    );
  }
}
