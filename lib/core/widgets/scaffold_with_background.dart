import 'package:flutter/material.dart';

import 'background_image_full.dart';

class ScaffoldWithBackground extends StatelessWidget {
  const ScaffoldWithBackground({
    super.key,
    required this.body,
    this.onPop,
    this.title = 'Retour',
    this.addBackgroundImage = true,
    this.actions,
    this.persistentFooterButtons,
  });

  final Widget body;
  final VoidCallback? onPop;
  final String? title;
  final bool? addBackgroundImage;
  final List<Widget>? actions;

  final List<Widget>? persistentFooterButtons;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        persistentFooterButtons: persistentFooterButtons,
        // extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // extendBodyBehindAppBar: true,
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
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
                    title ?? 'Retour',
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
          actions: actions,
        ),
        body: Stack(
          children: [
            if (addBackgroundImage ?? true)
              const Positioned(
                bottom: 10,
                left: 10,
                child: BackgroundImageFull(),
              ),
            body,
          ],
        ),
      ),
    );
  }
}
