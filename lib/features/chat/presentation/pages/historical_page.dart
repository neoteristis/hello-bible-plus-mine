import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/features/chat/presentation/pages/chat_page.dart';

import '../../../../core/constants/pagination_const.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/historical_bloc/historical_bloc.dart';
import '../widgets/historical/historical_item_widget.dart';

class HistoricalPage extends StatefulWidget {
  static const String route = 'history';

  const HistoricalPage({super.key});

  @override
  State<HistoricalPage> createState() => _HistoricalPageState();
}

class _HistoricalPageState extends State<HistoricalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Mon historique',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
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
      ),
      body: BlocBuilder<HistoricalBloc, HistoricalState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case Status.loaded:
              return const HistoryLoaded();
            case Status.failed:
              return const Center(
                child: Text(
                  'Une erreur s\'est produite',
                ),
              );
            default:
              return const Center(
                child: CustomProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

class HistoryLoaded extends StatelessWidget {
  const HistoryLoaded({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoricalBloc, HistoricalState>(
      buildWhen: (previous, current) =>
          previous.historicals != current.historicals ||
          previous.scrollController != current.scrollController ||
          previous.hasReachedMax != current.hasReachedMax ||
          previous.isRefresh != current.isRefresh,
      builder: (context, state) {
        final historicals = state.historicals;
        if (historicals == null || historicals.isEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    context
                        .read<HistoricalBloc>()
                        .add(const HistoricalFetched(isRefresh: true));
                  },
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 50,
                  )),
              const Text('Aucune conversation disponible'),
            ],
          ));
        }
        // final List old = [];
        // final List todays = [];
        // for (final e in historicals) {
        //   if (!e.messages.last.createdAt!.isAtSameDateAsNow) {
        //     old.add(e);
        //   } else {
        //     todays.add(e);
        //   }
        // }
        final historicalCount = state.historicals!.length;
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<HistoricalBloc>()
                .add(const HistoricalFetched(isRefresh: true));
          },
          child: Stack(
            children: [
              // ListView(
              //   controller: state.scrollController,
              //   physics: const AlwaysScrollableScrollPhysics(),
              //   children: [
              //     if (todays.isNotEmpty)
              //       const HeadingSeparatorWidget('Aujourd\'hui'),
              //     if (todays.isNotEmpty)
              //       ...todays.map(
              //         (e) {
              //           return HistoricalItemWidget(
              //             historic: e!,
              //           );
              //         },
              //       ),
              //     if (old.isNotEmpty)
              //       const HeadingSeparatorWidget('Anciennes'),
              //     if (old.isNotEmpty)
              //       ...old.map(
              //         (e) {
              //           if (e != null) {
              //             return HistoricalItemWidget(
              //               historic: e,
              //             );
              //           }
              //           return const SizedBox.shrink();
              //         },
              //       ),
              //   ],
              // ),
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: state.scrollController,
                itemBuilder: (context, index) => index >= historicalCount &&
                        historicalCount >= itemNumber
                    ? const BottomLoader()
                    : GestureDetector(
                        onTap: () {
                          context.read<ChatBloc>().add(ChatConversationInited(
                                historical: historicals[index],
                              ));
                          context.go('/${ChatPage.route}');
                        },
                        child: HistoricalItemWidget(
                          historic: historicals[index],
                        ),
                      ),
                itemCount: state.hasReachedMax! || historicalCount < itemNumber
                    ? state.historicals!.length
                    : state.historicals!.length + 1,
              ),
              state.isRefresh!
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history_rounded),
      title: ShimmerWidget.rectangular(
        height: 10,
        width: MediaQuery.sizeOf(context).width * .7,
      ),
      subtitle: ShimmerWidget.rectangular(
        height: 10,
        width: MediaQuery.sizeOf(context).width * .5,
      ),
    );
  }
}
