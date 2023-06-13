import 'package:flutter/material.dart';

import '../../../../../core/widgets/rounded_loading_button.dart';

class SocialConnectButton extends StatelessWidget {
  const SocialConnectButton({
    super.key,
    this.color,
    this.icon,
    this.label,
    required this.onPressed,
    this.child,
  });

  final Color? color;
  final Widget? icon;
  final String? label;
  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: RoundedLoadingButton(
          color: color,
          controller: RoundedLoadingButtonController(),
          onPressed: onPressed,
          borderRadius: 10,
          child: child ??
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    const SizedBox(
                      width: 10,
                    ),
                    if (label != null)
                      Text(
                        label!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
