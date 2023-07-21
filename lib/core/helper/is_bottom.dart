import 'package:flutter/material.dart';

bool isBottom({required ScrollController scrollController, double? offset}) {
  if (!scrollController.hasClients) {
    return false;
  }
  final maxScroll = scrollController.position.maxScrollExtent;
  final currentScroll = scrollController.offset;
  if (offset != null) {
    return currentScroll >= (maxScroll * offset);
  }
  return currentScroll >= (maxScroll * .9);
}
