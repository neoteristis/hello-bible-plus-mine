import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.url, {
    super.key,
    this.color,
  });

  final String url;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return url.contains('svg')
        ? SvgPicture.network(
            url,
            width: 20,
            // width: 25,
            color: color,
          )
        : Image.network(
            url,
            width: 20,
            // width: 25,
            color: color,
          );
  }
}
