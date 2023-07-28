import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageViewChild extends StatelessWidget {
  const PageViewChild({
    super.key,
    required this.images,
    required this.title,
    required this.body,
    this.extendImage = true,
  });

  final List<String> images;
  final String title;
  final String body;
  final bool? extendImage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(
            flex: 1,
          ),
          SvgPicture.asset(
            images.first,
            // width: extendImage! ? MediaQuery.of(context).size.width : null,
            height: height * 0.4,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}