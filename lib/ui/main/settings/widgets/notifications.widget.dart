import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';
import 'package:tasks_go_brr/ui/custom/button_icon_rounded.dart';
import 'package:tasks_go_brr/ui/main/settings/settings_view_model.dart';
import 'package:tasks_go_brr/ui/main/settings/widgets/category_title.widget.dart';
import 'package:tasks_go_brr/utils/time.dart';

import 'notification_layout.dialog.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key, required this.model});

  final SettingsViewModel model;

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CategoryTitleWidget(text: "settings.notifications".tr()),
            const SizedBox(width: Margin.small),
            SizedBox(
              height: 44,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  value: widget.model.settings.isNotificationsEnabled,
                  activeColor: context.primary,
                  inactiveTrackColor: context.onSurface.withOpacity(.3),
                  splashRadius: 0,
                  onChanged: (value) async {
                    widget.model.settings.isNotificationsEnabled = value;
                    await widget.model.updateSettings();
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
        AnimatedSizeAndFade(
          child: widget.model.settings.isNotificationsEnabled
              ? Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: Margin.middle.w * 2),
                      child: AnimatedGestureDetector(
                        onTap: () => _showNotificationLayoutDialog(),
                        child: Text(
                          "layouts".tr(),
                          style: TextStyle(
                            color: context.onSurfaceAccent,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimens.text_normal_smaller,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Margin.small.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        left: Margin.middle.w * 2,
                      ),
                      child: _titledButtonWidget(
                        onTap: () async {
                          var result = await Routes.showTimePicker(context,
                              value: widget
                                  .model.settings.remindEveryMorningTime
                                  .toDate(),
                              isFirstHalfOfDay: true);

                          if (result != null) {
                            widget.model.settings.remindEveryMorningTime =
                                result.millisecondsSinceEpoch;
                            await widget.model.updateSettings();
                            setState(() {});
                          }
                        },
                        title: "in_the_morning".tr(),
                        textButton: Time.getTimeFromMilliseconds(
                            widget.model.settings.remindEveryMorningTime),
                      ),
                    ),
                    SizedBox(
                      height: Margin.small.h,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                        left: Margin.middle.w * 2,
                      ),
                      child: _titledButtonWidget(
                        onTap: () async {
                          var result = await Routes.showTimePicker(context,
                              value: widget
                                  .model.settings.remindEveryEveningTime
                                  .toDate(),
                              isFirstHalfOfDay: false);

                          if (result != null) {
                            widget.model.settings.remindEveryEveningTime =
                                result.millisecondsSinceEpoch;
                            await widget.model.updateSettings();
                            setState(() {});
                          }
                        },
                        title: "in_the_evening".tr(),
                        textButton: Time.getTimeFromMilliseconds(
                            widget.model.settings.remindEveryEveningTime),
                      ),
                    ),
                    SizedBox(
                      height: Margin.middle.h,
                    ),
                  ],
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _titledButtonWidget({
    required String title,
    required String textButton,
    required VoidCallback onTap,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.onSurfaceAccent,
            fontWeight: FontWeight.w500,
            fontSize: Dimens.text_normal_smaller,
          ),
        ),
        const SizedBox(width: Margin.small),
        _buttonRoundedWithIcon(
          text: textButton,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget _buttonRoundedWithIcon({
    IconData? icon,
    required VoidCallback onTap,
    String? text,
  }) {
    return ButtonIconRounded(
      icon: icon,
      onTap: onTap,
      backgroundColor: context.surfaceAccent,
      iconColor: context.onSurface,
      text: text ?? null,
      textColor: context.onSurface,
      padding: const EdgeInsets.symmetric(
        vertical: Paddings.small,
        horizontal: Paddings.middle,
      ),
    );
  }

  _showNotificationLayoutDialog() {
    showDialog(
      context: context,
      builder: (contextDialog) => NotificationLayoutDialog(
        model: widget.model,
      ),
    );
  }
}
