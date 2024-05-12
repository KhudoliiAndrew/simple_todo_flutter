import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/constants.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/checkbox_custom.dart';
import 'package:tasks_go_brr/ui/custom/dialog_parts.dart';
import 'package:tasks_go_brr/ui/main/settings/settings_view_model.dart';

class NotificationLayoutDialog extends StatefulWidget {
  final SettingsViewModel model;

  const NotificationLayoutDialog({Key? key, required this.model})
      : super(key: key);

  @override
  _NotificationLayoutDialogState createState() =>
      _NotificationLayoutDialogState();
}

class _NotificationLayoutDialogState extends State<NotificationLayoutDialog> {
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
          horizontal: Paddings.small,
          vertical: Paddings.middle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogTitle(
              text: "dialog.choose_notifications_type".tr(),
            ),
            SizedBox(
              height: Margin.middle.h,
            ),
            _item(NotificationsLayout.ONLY_TASKS),
            _item(NotificationsLayout.ACTIVITY_REMINDER),
            _item(NotificationsLayout.DAILY_REMINDER),
            SizedBox(
              height: Margin.middle.h,
            ),
            DialogPositiveButton(
              onTap: () async {
                await widget.model.updateSettings();
                setState(() {});
                Routes.back(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(int id) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(Margin.small),
          child: CheckboxCustom(
              value: widget.model.settings.notificationsLayout[id],
              onChanged: (value) => setState(() =>
                  widget.model.settings.notificationsLayout[id] = value!)),
        ),
        Flexible(
          child: Text(
            getTitle(id),
            style: TextStyle(
                fontWeight: FontWeight.w500, color: context.onSurfaceAccent),
          ),
        ),
      ],
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
