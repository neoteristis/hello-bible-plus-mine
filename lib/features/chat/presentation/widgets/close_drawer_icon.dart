import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_constants.dart';
import '../bloc/chat_bloc/chat_bloc.dart';

class CloseDrawerIcon extends StatelessWidget {
  const CloseDrawerIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.read<ChatBloc>().scaffoldKey.currentState?.closeDrawer();
            },
            child: Container(
              color: ColorConstants.background,
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width * 0.15,
              child: const Icon(
                Icons.close_rounded,
                color: ColorConstants.primary,
                size: 40,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
