import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';

class ButtonIconRounded extends StatelessWidget {
  Color? backgroundColor;
  Color? iconColor;
  final IconData? icon;
  final VoidCallback onTap;
  final EdgeInsets padding;
  final String? text;
  final Alignment alignment;
  Color? textColor;

  ButtonIconRounded({
    Key? key,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    required this.onTap,
    this.padding = const EdgeInsets.all(0.0),
    this.alignment = Alignment.centerLeft,
    this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundColor = backgroundColor ?? context.primary;
    iconColor = iconColor ?? context.onPrimary;
    textColor = textColor ?? context.onSurface;

    return AnimatedGestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radiuss.small_smaller),
        ),
        child: text != null && text!.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (alignment == Alignment.centerLeft) getIcon(),
                  if (alignment == Alignment.centerLeft && icon != null)
                    SizedBox(width: Margin.small.w),
                  Text(
                    text!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  if (alignment == Alignment.centerRight && icon != null)
                    SizedBox(width: Margin.small.w),
                  if (alignment == Alignment.centerRight) getIcon(),
                ],
              )
            : getIcon(),
      ),
    );
  }

  Widget getIcon() {
    return icon != null ? Icon(icon, color: iconColor) : Container();
  }
}
