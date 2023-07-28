import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/core/helper/notifications.dart';
import 'package:gpt/core/widgets/custom_progress_indicator.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/features/home/presentation/widgets/categories_by_section_widget.dart';
import 'package:gpt/features/home/presentation/widgets/custom_home_app_bar.dart';

import '../../../../core/constants/status.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  static const String route = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(ChatCategoriesBySectionFetched());
    configureNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHomeAppBar(),
      endDrawer: const CustomDrawer(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state.status) {
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
                      'Une erreur s\'est produite',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChatCategoriesBySectionFetched());
                      },
                      icon: Icon(Icons.refresh_rounded,
                          color: Theme.of(context).primaryColor),
                      label: Text(
                        'Rafraichir',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              );
            case Status.loaded:
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<HomeBloc>()
                      .add(ChatCategoriesBySectionFetched());
                },
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.categoriesBySection.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 30,
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
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
