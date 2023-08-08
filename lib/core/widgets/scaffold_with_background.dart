import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../l10n/function.dart';

class ScaffoldWithBackground extends StatelessWidget {
  const ScaffoldWithBackground({
    super.key,
    required this.body,
    this.onPop,
    this.title,
    this.addBackgroundImage = true,
    this.actions,
    this.persistentFooterButtons,
    this.hasAppBar = true,
  });

  final Widget body;
  final VoidCallback? onPop;
  final String? title;
  final bool? addBackgroundImage;
  final List<Widget>? actions;
  final bool hasAppBar;

  final List<Widget>? persistentFooterButtons;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      actions: actions,
      title: Visibility(
        visible: onPop != null,
        child: GestureDetector(
          onTap: onPop,
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Text(
                title ?? dict(context).goback,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            child: SvgPicture.asset(
              'assets/images/background_image.svg',
            ),
          ),
          Scaffold(
            persistentFooterButtons: persistentFooterButtons,
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: hasAppBar ? appBar : null,
            body: SafeArea(child: body),
          ),
        ],
      ),
    );
  }
}
