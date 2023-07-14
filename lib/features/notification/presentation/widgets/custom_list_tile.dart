import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.leading,
    required this.title,
    this.switchValue,
    this.onChanged,
    this.description,
  });

  final Widget? leading;
  final Widget? title;
  final String? description;
  final bool? switchValue;
  final ValueSetter<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: leading,
          title: title,
          // trailing: Transform.scale(
          //   scale: 0.8,
          //   origin: const Offset(50, 0),
          //   child: CupertinoSwitch(
          //     value: switchValue ?? true,
          //     onChanged: onChanged,
          //   ),
          // ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            description ?? '',
          ),
        ),
      ],
    );
  }
}
