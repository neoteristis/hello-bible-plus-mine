import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/core/widgets/custom_drawer.dart';
import 'package:gpt/features/chat/presentation/pages/chat_page.dart';

import '../../../../core/constants/pagination_const.dart';
import '../../../../core/constants/status.dart';
import '../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../core/widgets/custom_progress_indicator.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../domain/entities/historical_conversation.dart';
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
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HistoricalBloc>().add(const HistoricalFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
              scaffoldKey.currentState?.openEndDrawer();
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
        final historicalCount = state.historicals!.length;
        return RefreshIndicator(
          onRefresh: () async {
            context
                .read<HistoricalBloc>()
                .add(const HistoricalFetched(isRefresh: true));
          },
          child: Stack(
            children: [
              ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: state.scrollController,
                itemBuilder: (context, index) =>
                    index >= historicalCount && historicalCount >= itemNumber
                        ? const BottomLoader()
                        : HistoricalSlidableItem(
                            historic: historicals[index],
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

class HistoricalSlidableItem extends StatefulWidget {
  const HistoricalSlidableItem({super.key, required this.historic});

  final HistoricalConversation historic;

  @override
  State<HistoricalSlidableItem> createState() => _HistoricalSlidableItemState();
}

class _HistoricalSlidableItemState extends State<HistoricalSlidableItem> {
  final ScrollController _scrollController = ScrollController();

  bool atEndOfList = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        atEndOfList = true;
      } else {
        atEndOfList = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final historic = widget.historic;
    return Container(
      height: 70,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: [
          SizedBox(
            height: 70,
            width: MediaQuery.sizeOf(context).width,
            child: GestureDetector(
              onTap: () {
                context.read<ChatBloc>().add(
                      ChatConversationInited(
                        historical: historic,
                      ),
                    );
                context.go('/${HistoricalPage.route}/${ChatPage.route}');
              },
              child: HistoricalItemWidget(
                historic: historic,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                color: Colors.grey,
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController controller =
                              TextEditingController();
                          controller.text = historic.title ?? '';
                          return CustomAlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: TextFormField(
                                    maxLines: 4,
                                    controller: controller,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text('Annuler'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                  );
                                  context.read<HistoricalBloc>().add(
                                        HistoricalEdited(
                                          historicalConversation: historic,
                                          title: controller.text,
                                        ),
                                      );
                                  context.pop();
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                color: Colors.red,
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.minScrollExtent,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                    context.read<HistoricalBloc>().add(
                          HistoricalDeleted(
                            historic,
                          ),
                        );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
