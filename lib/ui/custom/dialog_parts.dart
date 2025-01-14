import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';

class DialogTitle extends StatelessWidget {
  final String text;

  const DialogTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Margin.middle.w),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: Dimens.text_normal_bigger,
        ),
      ),
    );
  }
}

class DialogDescription extends StatelessWidget {
  final String text;

  const DialogDescription({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Margin.middle.w),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.onSurfaceAccent,
          fontWeight: FontWeight.normal,
          fontSize: Dimens.text_small_bigger,
        ),
      ),
    );
  }
}

class DialogPositiveButton extends StatelessWidget {
  final VoidCallback onTap;

  const DialogPositiveButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedGestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.primary,
            borderRadius: BorderRadius.all(Radiuss.small_smaller),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: Paddings.small, vertical: Paddings.small_bigger),
          child: Center(
              child: Text(
            "action.save".tr(),
            style: TextStyle(
                color: context.onPrimary, fontWeight: FontWeight.bold),
          ))),
    );
  }
}
