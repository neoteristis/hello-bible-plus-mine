import 'package:flutter/material.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
    this.label,
    this.value,
    this.addBackground = false,
  });

  final String? label;
  final String? value;
  final bool? addBackground;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          if (label != null) Text('$label :'),
          const Spacer(),
          Container(
            padding: addBackground! ? const EdgeInsets.all(5) : null,
            decoration: addBackground!
                ? BoxDecoration(
                    color: const Color(0xFFFEE269),
                    borderRadius: BorderRadius.circular(5),
                  )
                : null,
            child: Text(
              value ?? '',
              style: addBackground!
                  ? const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
