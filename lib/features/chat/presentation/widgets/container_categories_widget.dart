import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/status.dart';
import '../../../../core/db_services/db_services.dart';
import '../../../../core/routes/route_name.dart';
import '../../../../injections.dart';
import '../bloc/historical_bloc/historical_bloc.dart';
import 'categories_widget.dart';
import 'historical/historical_item_widget.dart';

class ContainerCategoriesWidget extends StatelessWidget {
  const ContainerCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LastHistoricWidget(),
          CategoriesWidget(),
          // TextButton(
          //     onPressed: () {
          //       getIt<DbService>().deleteToken();
          //       getIt<DbService>().deleteUser();
          //     },
          //     child: Text('deconnexion')),
          // TextButton(
          //     onPressed: () {
          //       context.go(RouteName.subscribe);
          //     },
          //     child: Text('subscribe'))
        ],
      ),
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
