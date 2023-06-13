import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';

import '../../../../core/constants/status.dart';
import '../bloc/historical_bloc/historical_bloc.dart';
import '../widgets/historical/historical_item_widget.dart';

class HistoricalPage extends StatelessWidget {
  const HistoricalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<HistoricalBloc, HistoricalState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.loaded:
              final historicals = state.historicals;
              if (historicals == null || historicals.isEmpty) {
                return const Text('La liste est vide');
              }
              return ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.read<ChatBloc>().add(
                        ChatConversationInited(historical: historicals[index]));
                    context.pop();
                  },
                  child: HistoricalItemWidget(
                    historic: historicals[index],
                  ),
                ),
                itemCount: historicals.length,
              );
            case Status.failed:
              return const Center(
                child: Text('Une erreur s\'est produite'),
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
