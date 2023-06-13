import 'package:flutter/material.dart';

import 'background_image_full.dart';

class ScaffoldWithBackground extends StatelessWidget {
  const ScaffoldWithBackground({
    super.key,
    required this.body,
    this.onPop,
  });

  final Widget body;
  final VoidCallback? onPop;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: TextButton.icon(
              onPressed: onPop,
              icon: Icon(Icons.arrow_back_ios),
              label: Text('Retour')),
        ),
        body: Stack(
          children: [
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
