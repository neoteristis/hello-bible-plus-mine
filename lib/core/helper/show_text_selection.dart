import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:selectable/selectable.dart';

Future showTextSelection({
  required BuildContext context,
  required SelectableController selectionController,
  required String text,
}) {
  return showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Selectable(
                selectionController: selectionController,
                showPopup: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 20,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 17.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      );
    },
  );
}
