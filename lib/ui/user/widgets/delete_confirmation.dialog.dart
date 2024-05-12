import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/constants.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/icons/icons.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/dialog_parts.dart';

import 'icon_rounded.button.dart';

class DeleteConfirmationDialog extends StatefulWidget {
  const DeleteConfirmationDialog({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<DeleteConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: Container(
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.all(Radiuss.small_smaller),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Paddings.small_half,
          vertical: Paddings.middle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogTitle(text: "profile.delete_confirmation_title".tr()),
            SizedBox(height: Margin.middle_smaller.h),
            DialogDescription(
              text: "profile.delete_confirmation_description".tr(),
            ),
            SizedBox(height: Margin.middle.h),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconRoundedButton(
                        backgroundColor: context.surfaceAccent,
                        iconColor: context.onSurface,
                        icon: IconsC.back,
                        onTap: () => Routes.back(context)),
                  ),
                ),
                SizedBox(width: Margin.middle.w),
                IconRoundedButton(
                  backgroundColor: context.error,
                  icon: IconsC.delete,
                  iconColor: context.onSurface,
                  text: "profile.delete_all".tr(),
                  alignment: Alignment.centerRight,
                  onTap: () => Routes.back(context, result: "delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getTitle(int id) {
    switch (id) {
      case NotificationsLayout.ONLY_TASKS:
        return "notification_layout.only_tasks".tr();
      case NotificationsLayout.DAILY_REMINDER:
        return "notification_layout.daily_reminder".tr();
      case NotificationsLayout.ACTIVITY_REMINDER:
        return "notification_layout.activity_reminders".tr();
      default:
        return Constants.EMPTY_STRING.tr();
    }
  }
}
