import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../widgets/categories_widget.dart';
import '../widgets/chat_body.dart';
import '../widgets/custom_app_bar.dart';
import 'custom_drawer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<ChatBloc>().add(ChatCategoriesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFF8F4F1),
            key: context.read<ChatBloc>().scaffoldKey,
            appBar: CustomAppBar(),
            drawer: CustomDrawer(),
            body: state.conversation == null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF202040).withOpacity(0.08),
                            offset: const Offset(0, 8),
                            blurRadius: 16,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(
                          //     'Commencer un nouveau conversation',
                          //     style:
                          //         TextStyle(color: Colors.brown[400], fontSize: 16),
                          //   ),
                          // ),
                          CategoriesWidget(
                            isWhite: true,
                          ),
                        ],
                      ),
                    ),
                  )
                : ChatBody(),
          );
        },
      ),
    );
  }
}
