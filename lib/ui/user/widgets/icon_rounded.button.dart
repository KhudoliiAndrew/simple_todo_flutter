import 'package:flutter/material.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/ui/custom/button_icon_rounded.dart';

class IconRoundedButton extends StatelessWidget {
  const IconRoundedButton({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    this.icon,
    required this.onTap,
    this.alignment = Alignment.centerLeft,
    this.text,
  });

  final Color backgroundColor;
  final Color iconColor;
  final IconData? icon;
  final VoidCallback onTap;
  final String? text;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ButtonIconRounded(
      icon: icon,
      onTap: onTap,
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      text: text ?? null,
      alignment: alignment,
      textColor: context.onSurface,
      padding: const EdgeInsets.symmetric(
          vertical: Paddings.small, horizontal: Paddings.middle),
    );
  }
}
