// class AllwaysScrollableFixedPositionScrollPhysics extends ScrollPhysics {
//   /// Creates scroll physics that always lets the user scroll.
//   const AllwaysScrollableFixedPositionScrollPhysics({ScrollPhysics? parent})
//       : super(parent: parent);

//   @override
//   AllwaysScrollableFixedPositionScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return AllwaysScrollableFixedPositionScrollPhysics(
//         parent: buildParent(ancestor));
//   }

//   @override
//   double adjustPositionForNewDimensions({
//     required ScrollMetrics oldPosition,
//     required ScrollMetrics newPosition,
//     required bool isScrolling,
//     required double velocity,
//   }) {
//     if (isScrolling) {
//       return super.adjustPositionForNewDimensions(
//         oldPosition: oldPosition,
//         newPosition: newPosition,
//         isScrolling: isScrolling,
//         velocity: velocity,
//       );
//     }

//     return newPosition.maxScrollExtent - oldPosition.extentAfter;
//   }

//   @override
//   bool shouldAcceptUserOffset(ScrollMetrics position) => true;
// }

import 'package:flutter/material.dart';

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool? shouldRetain;
  const PositionRetainedScrollPhysics({
    super.parent,
    this.shouldRetain,
  });
  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );
    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;
    // Check if the new position exceeds the scrollable extents
    if (newPosition.maxScrollExtent < oldPosition.maxScrollExtent) {
      return position.clamp(
        oldPosition.minScrollExtent,
        oldPosition.maxScrollExtent,
      );
    }

    if (!isScrolling) {
      return position + diff;
    } else {
      return position;
    }
  }
}
// if (oldPosition.pixels > oldPosition.minScrollExtent &&
//     diff > 0 &&
//     !isScrolling) {
//   return position + diff;
// } else {
//   return position;
// }
//final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;
// if (isScrolling) {
//   return position;
// } else {
//   return position + diff;
// }

class PoositionRetainedScrollPhysics extends ScrollPhysics {
  final bool? shouldRetain;
  const PoositionRetainedScrollPhysics({
    super.parent,
    this.shouldRetain,
  });
  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    // Check if the new position exceeds the scrollable extents
    if (newPosition.maxScrollExtent < oldPosition.maxScrollExtent) {
      return position.clamp(
        oldPosition.minScrollExtent,
        oldPosition.maxScrollExtent,
      );
    }

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;

    if (oldPosition.pixels > oldPosition.minScrollExtent &&
        diff > 0 &&
        !isScrolling) {
      return position + diff;
    } else {
      return position;
    }
  }
}
