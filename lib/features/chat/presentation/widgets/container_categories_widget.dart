import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/routes/route_name.dart';
import '../bloc/historical_bloc/historical_bloc.dart';
import 'categories_widget.dart';
import 'historical/historical_item_widget.dart';

class ContainerCategoriesWidget extends StatelessWidget {
  const ContainerCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CategoriesWidget(),
    );
  }
}

class LastHistoricWidget extends StatelessWidget {
  const LastHistoricWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricalBloc, HistoricalState>(
      buildWhen: (previous, current) =>
          previous.historicals != current.historicals ||
          previous.status != current.status,
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Text('loading');
          case Status.loaded:
            final lastConverstation = state.historicals;
            if (lastConverstation == null || lastConverstation.isEmpty) {
              return const Text('débutez votre conversation');
            }
            return GestureDetector(
              onTap: () {
                context.go(RouteName.historical);
              },
              child: HistoricalItemWidget(
                historic: lastConverstation.first,
              ),
            );
          case Status.failed:
            return const Text('an error occured');
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
