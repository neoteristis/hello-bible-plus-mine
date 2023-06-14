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
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Visibility(
            visible: onPop != null,
            child: GestureDetector(
              onTap: onPop,
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Color(0xFF24282E),
                  ),
                  Text(
                    'Retour',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Color(0xFF24282E),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
