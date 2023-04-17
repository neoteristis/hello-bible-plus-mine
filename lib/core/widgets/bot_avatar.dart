import 'package:flutter/material.dart';

class BotAvatar extends StatelessWidget {
  const BotAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.android_rounded,
        color: Colors.black54,
        size: 20,
      ),
    );
  }
}
