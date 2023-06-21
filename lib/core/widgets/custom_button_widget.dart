import 'package:flutter/material.dart';
import 'package:gpt/core/widgets/rounded_loading_button.dart';

enum ButtonType {
  white,
  black,
  orange,
  blue,
}

abstract class CustomButtonWidget {
  factory CustomButtonWidget(ButtonType type) {
    switch (type) {
      case ButtonType.white:
        return WhiteRoundedLoadingButton();
      case ButtonType.black:
        return BlackRoundedLoadingButton();
      case ButtonType.blue:
        return BlueRoundedLoadingButton();
      default:
        return OrangeRoundedLoadingButton();
    }
  }
  Widget build({
    RoundedLoadingButtonController? controller,
    required BuildContext context,
    bool? animateOnTap,
    required VoidCallback onPressed,
    double? width,
    double? height,
    required String label,
    double? borderRadius,
  });
}

class WhiteRoundedLoadingButton implements CustomButtonWidget {
  @override
  Widget build({
    RoundedLoadingButtonController? controller,
    required BuildContext context,
    bool? animateOnTap,
    required VoidCallback onPressed,
    double? width,
    double? height,
    required String label,
    double? borderRadius,
  }) {
    return RoundedLoadingButton(
      controller: controller ?? RoundedLoadingButtonController(),
      color: Colors.white,
      width: width ?? 300,
      height: height ?? 50,
      animateOnTap: animateOnTap ?? false,
      onPressed: onPressed,
      borderRadius: borderRadius ?? 35,
      child: Text(
        label,
        // style: CustomTextStyle(CustomFontWeight.medium).style(),
        // style: const TextStyle(
        //   color: primary,
        // ),
      ),
    );
  }
}

class BlackRoundedLoadingButton implements CustomButtonWidget {
  @override
  Widget build({
    RoundedLoadingButtonController? controller,
    required BuildContext context,
    bool? animateOnTap,
    required VoidCallback onPressed,
    double? width,
    double? height,
    required String label,
    double? borderRadius,
  }) {
    return RoundedLoadingButton(
      controller: controller ?? RoundedLoadingButtonController(),
      color: Theme.of(context).colorScheme.onSurface,
      width: width ?? MediaQuery.of(context).size.width * .85,
      height: height ?? 50,
      animateOnTap: animateOnTap ?? false,
      borderRadius: borderRadius ?? 35,
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// RoundedLoadingButton(
//                   controller: RoundedLoadingButtonController(),
//                   animateOnTap: false,
//                   width: MediaQuery.of(context).size.width * .85,
//                   color: Color(0xFF24282E),
//                   onPressed: () {},
//                   child: Text('Continuer',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14)),
//                 )

class BlueRoundedLoadingButton implements CustomButtonWidget {
  @override
  Widget build({
    RoundedLoadingButtonController? controller,
    required BuildContext context,
    bool? animateOnTap,
    required VoidCallback onPressed,
    double? width,
    double? height,
    required String label,
    double? borderRadius,
  }) {
    return RoundedLoadingButton(
      controller: controller ?? RoundedLoadingButtonController(),
      // color: tertiary,
      width: width ?? 300,
      height: height ?? 50,
      animateOnTap: animateOnTap ?? false,
      onPressed: onPressed,
      child: Text(
        label,
        // style:
        //     CustomTextStyle(CustomFontWeight.medium).style(color: Colors.white),
      ),
    );
  }
}

class OrangeRoundedLoadingButton implements CustomButtonWidget {
  @override
  Widget build({
    RoundedLoadingButtonController? controller,
    required BuildContext context,
    bool? animateOnTap,
    required VoidCallback onPressed,
    double? width,
    double? height,
    required String label,
    double? borderRadius,
  }) {
    return RoundedLoadingButton(
      controller: controller ?? RoundedLoadingButtonController(),
      // color: secondary,
      width: width ?? 300,
      height: height ?? 50,
      animateOnTap: animateOnTap ?? false,
      borderRadius: borderRadius ?? 35,
      onPressed: onPressed,
      child: Text(
        label,
        // style:
        //     CustomTextStyle(CustomFontWeight.medium).style(color: Colors.white),
      ),
    );
  }
}
