import 'dart:ui';
import 'package:flutter/material.dart';

class FocusedMenuItem {
  Color? backgroundColor;
  Widget title;
  Icon? trailingIcon;
  Function onPressed;

  FocusedMenuItem({
    this.backgroundColor,
    required this.title,
    this.trailingIcon,
    required this.onPressed,
  });
}

class CustomFocusedMenuHolder extends StatefulWidget {
  final Widget child;
  final double? menuItemExtent;
  final double? menuWidth;
  final List<FocusedMenuItem> menuItems;
  final bool? animateMenuItems;
  final BoxDecoration? menuBoxDecoration;
  final Function onPressed;
  final Duration? duration;
  final double? blurSize;
  final Color? blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;

  /// Open with tap insted of long press.
  final bool openWithTap;

  const CustomFocusedMenuHolder({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.menuItems,
    this.duration,
    this.menuBoxDecoration,
    this.menuItemExtent,
    this.animateMenuItems,
    this.blurSize,
    this.blurBackgroundColor,
    this.menuWidth,
    this.bottomOffsetHeight,
    this.menuOffset,
    this.openWithTap = false,
  }) : super(key: key);

  @override
  _CustomFocusedMenuHolderState createState() =>
      _CustomFocusedMenuHolderState();
}

class _CustomFocusedMenuHolderState extends State<CustomFocusedMenuHolder> {
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
    return GestureDetector(
      key: containerKey,
      onTap: () async {
        widget.onPressed();
        if (widget.openWithTap) {
          await openMenu(context);
        }
      },
      onLongPress: () async {
        if (!widget.openWithTap) {
          await openMenu(context);
        }
      },
      child: widget.child,
    );
  }

  Future openMenu(BuildContext context) async {
    getOffset();
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(
          microseconds: 100,
        ),
        reverseTransitionDuration: const Duration(
          milliseconds: 50,
        ),
        pageBuilder: (context, animation, secondaryAnimation) {
          animation = Tween(begin: 0.0, end: 1.0).animate(animation);
          return FadeTransition(
            opacity: animation,
            child: FocusedMenuDetails(
              itemExtent: widget.menuItemExtent,
              menuBoxDecoration: widget.menuBoxDecoration,
              childOffset: childOffset,
              childSize: childSize,
              menuItems: widget.menuItems,
              blurSize: widget.blurSize,
              menuWidth: widget.menuWidth,
              blurBackgroundColor: widget.blurBackgroundColor,
              animateMenu: widget.animateMenuItems ?? true,
              bottomOffsetHeight: widget.bottomOffsetHeight ?? 0,
              menuOffset: widget.menuOffset ?? 0,
              child: widget.child,
            ),
          );
        },
        fullscreenDialog: true,
        opaque: false,
      ),
    );
  }
}

class FocusedMenuDetails extends StatefulWidget {
  final List<FocusedMenuItem> menuItems;
  final BoxDecoration? menuBoxDecoration;
  final Offset childOffset;
  final double? itemExtent;
  final Size? childSize;
  final Widget child;
  final bool animateMenu;
  final double? blurSize;
  final double? menuWidth;
  final Color? blurBackgroundColor;
  final double? bottomOffsetHeight;
  final double? menuOffset;

  const FocusedMenuDetails({
    Key? key,
    required this.menuItems,
    required this.child,
    required this.childOffset,
    required this.childSize,
    required this.menuBoxDecoration,
    required this.itemExtent,
    required this.animateMenu,
    required this.blurSize,
    required this.blurBackgroundColor,
    required this.menuWidth,
    this.bottomOffsetHeight,
    this.menuOffset,
  }) : super(key: key);

  @override
  State<FocusedMenuDetails> createState() => _FocusedMenuDetailsState();
}

class _FocusedMenuDetailsState extends State<FocusedMenuDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0.4, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingTop = MediaQuery.of(context).viewPadding.top;

    final maxMenuHeight = size.height * 0.45;
    final listHeight = widget.menuItems.length * (widget.itemExtent ?? 50.0);

    final maxMenuWidth = widget.menuWidth ?? (size.width * 0.70);
    final menuHeight = listHeight < maxMenuHeight ? listHeight : maxMenuHeight;
    final leftOffset = (widget.childOffset.dx + maxMenuWidth) < size.width
        ? widget.childOffset.dx
        : (widget.childOffset.dx - maxMenuWidth + widget.childSize!.width);
    double topOffset = (widget.childOffset.dy +
                menuHeight +
                widget.childSize!.height) <
            size.height - widget.bottomOffsetHeight!
        ? widget.childOffset.dy + widget.childSize!.height + widget.menuOffset!
        : widget.childOffset.dy - menuHeight - widget.menuOffset!;

    topOffset = topOffset < 0 ? paddingTop : topOffset;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedBuilder(
            animation: controller,
            builder: (context, Widget? child) {
              return GestureDetector(
                onTap: () {
                  controller
                      .animateBack(0.5)
                      .whenComplete(() => Navigator.of(context).pop());
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blurSize ?? 4,
                    sigmaY: widget.blurSize ?? 4,
                  ),
                  child: Container(
                    color: (widget.blurBackgroundColor ?? Colors.black)
                        .withOpacity(animation.value * 0.5),
                  ),
                ),
              );
            },
            child: GestureDetector(
              onTap: () {
                controller
                    .animateBack(0.5)
                    .whenComplete(() => Navigator.of(context).pop());
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blurSize ?? 4,
                  sigmaY: widget.blurSize ?? 4,
                ),
                child: Container(
                  color: (widget.blurBackgroundColor ?? Colors.black)
                      .withOpacity(1.0),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget? child) {
              double scale = 1;
              if (widget.childSize!.height >= size.height) {
                scale = ((size.height -
                            (MediaQuery.of(context).viewPadding.top +
                                MediaQuery.of(context).viewPadding.bottom)) /
                        widget.childSize!.height) /
                    (animation.value);

                final double yPosition = (-size.height * scale) +
                    (MediaQuery.of(context).viewPadding.top +
                        MediaQuery.of(context).viewPadding.bottom);
                return Positioned(
                  top: yPosition,
                  left: widget.childOffset.dx,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.center,
                    child: child ?? Container(),
                  ),
                );
              }
              return Positioned(
                top: widget.childOffset.dy,
                left: widget.childOffset.dx,
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.center,
                  child: child,
                ),
              );
            },
            child: SizedBox(
              width: widget.childSize!.width,
              height: widget.childSize!.height,
              child: widget.child,
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
                decoration: widget.menuBoxDecoration ??
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
                    itemCount: widget.menuItems.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final FocusedMenuItem item = widget.menuItems[index];
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
                              height: widget.itemExtent ?? 50.0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 14),
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
