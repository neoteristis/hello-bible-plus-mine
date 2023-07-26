import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_focused_menu.dart';

class BubbleHero extends StatelessWidget {
  const BubbleHero({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: child,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onLongPress: () {
            if (onTap != null) {
              onTap!();
            }
          },
          child: child,
        ),
      ),
    );
  }
}

class CustomHeroFocused extends StatefulWidget {
  const CustomHeroFocused({
    super.key,
    required this.child,
    required this.menuItems,
  });

  final Widget child;
  final List<FocusedMenuItem> menuItems;

  @override
  State<CustomHeroFocused> createState() => _CustomHeroFocusedState();
}

class _CustomHeroFocusedState extends State<CustomHeroFocused> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = const Offset(0, 0);
  Size? childSize;

  void getOffset() {
    final RenderBox renderBox =
        containerKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BubbleHero(
      key: containerKey,
      onTap: () async {
        getOffset();
        await Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            fullscreenDialog: true,
            opaque: true,
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: CustomHeroFocusedDetailWidget(
                  bubble: widget.child,
                  childSize: childSize,
                  menuBoxDecoration: null,
                  itemExtent: 40.0,
                  blurSize: 5.0,
                  menuWidth: 200,
                  menuItems: widget.menuItems,
                  childOffset: childOffset,
                  bottomOffsetHeight: 20,
                  menuOffset: 10,
                ),
              );
            },
          ),
        );
      },
      child: widget.child,
    );
  }
}

class CustomHeroFocusedDetailWidget extends StatelessWidget {
  const CustomHeroFocusedDetailWidget({
    super.key,
    required this.bubble,
    this.childSize,
    required this.menuBoxDecoration,
    required this.itemExtent,
    required this.blurSize,
    required this.menuWidth,
    required this.menuItems,
    required this.childOffset,
    required this.bottomOffsetHeight,
    required this.menuOffset,
  });

  final List<FocusedMenuItem> menuItems;
  final Widget bubble;
  final Size? childSize;
  final Offset childOffset;
  final BoxDecoration? menuBoxDecoration;
  final double itemExtent;
  final double blurSize;
  final double menuWidth;
  final double menuOffset;
  final double bottomOffsetHeight;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingTop = MediaQuery.of(context).viewPadding.top;

    final maxMenuHeight = size.height * 0.45;
    final listHeight = menuItems.length * (itemExtent);

    final maxMenuWidth = menuWidth;
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = (childOffset.dx + maxMenuWidth) < size.width
        ? childOffset.dx
        : (childOffset.dx - maxMenuWidth + childSize!.width);
    double topOffset = (childOffset.dy + menuHeight + childSize!.height) <
            size.height - bottomOffsetHeight
        ? childOffset.dy + childSize!.height + menuOffset
        : childOffset.dy - menuHeight - menuOffset;

    topOffset = topOffset < 0 ? paddingTop : topOffset;
    final paddingVertical = (MediaQuery.of(context).viewPadding.top +
        MediaQuery.of(context).viewPadding.bottom);

    final isBubbleHeightContainInList =
        (size.height - paddingVertical) > childSize!.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 4,
                sigmaY: 4,
              ),
              child: Container(
                color: Colors.black12.withOpacity(0.7),
              ),
            ),
          ),
          if (isBubbleHeightContainInList)
            Positioned(
              top: childOffset.dy,
              left: childOffset.dx,
              child: SizedBox(
                width: childSize?.width,
                child: BubbleHero(
                  child: bubble,
                ),
              ),
            ),
          if (!isBubbleHeightContainInList)
            TweenAnimationBuilder(
              tween: Tween(
                begin: 1.0,
                end: 2.0,
              ),
              builder: (BuildContext context, dynamic value, Widget? child) {
                double scale = 1.0;
                if ((size.height - paddingVertical) < childSize!.height) {
                  scale = ((size.height - paddingVertical) /
                          (childSize?.height ?? 800)) /
                      value;
                }
                return Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              duration: const Duration(
                milliseconds: 200,
              ),
              child: BubbleHero(
                child: bubble,
              ),
            ),
          Positioned(
            top: topOffset,
            left: leftOffset,
            child: TweenAnimationBuilder(
              duration: const Duration(
                milliseconds: 200,
              ),
              builder: (BuildContext context, dynamic value, Widget? child) {
                return Transform.scale(
                  scale: value,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              tween: Tween(begin: 0.0, end: 1.0),
              child: Container(
                width: maxMenuWidth,
                height: menuHeight,
                decoration: menuBoxDecoration ??
                    BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final FocusedMenuItem item = menuItems[index];
                      final Widget listItem = GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            item.onPressed();
                          },
                          child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                bottom: 1,
                              ),
                              color: item.backgroundColor ?? Colors.white,
                              height: itemExtent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 14,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    item.title,
                                    if (item.trailingIcon != null) ...[
                                      item.trailingIcon!
                                    ]
                                  ],
                                ),
                              )));

                      return listItem;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
