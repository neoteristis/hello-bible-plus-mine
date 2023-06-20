import 'package:flutter/material.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';

class SocialConnectButton extends StatelessWidget {
  const SocialConnectButton({
    super.key,
    this.color,
    this.icon,
    this.label,
    required this.onPressed,
    this.controller,
    this.child,
  });

  final Color? color;
  final Widget? icon;
  final String? label;
  final VoidCallback onPressed;
  final Widget? child;
  final RoundedLoadingButtonController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .65,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: RoundedLoadingButton(
          color: color,
          controller: controller ?? RoundedLoadingButtonController(),
          onPressed: onPressed,
          borderRadius: 10,
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (icon != null) Expanded(child: icon!),
                  SizedBox(
                    width: 5,
                  ),
                  if (label != null)
                    Expanded(
                      flex: 4,
                      child: Text(
                        label!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                ],
              ),
        ),
      ),
    );
  }
}
