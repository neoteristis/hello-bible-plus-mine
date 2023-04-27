import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotAvatar extends StatelessWidget {
  const BotAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: FaIcon(
        FontAwesomeIcons.faceSmileBeam,
        color: Color(0xff9e9cab),
        size: 20,
      ),
    );
  }
}
