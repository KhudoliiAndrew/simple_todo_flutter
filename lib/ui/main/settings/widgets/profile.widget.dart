import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';
import 'package:tasks_go_brr/ui/main/settings/settings_view_model.dart';

class ProfileWidget extends StatefulWidget {
  final SettingsViewModel model;

  const ProfileWidget({Key? key, required this.model}) : super(key: key);

  @override
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  late Future _futureInfo;
  bool _isLoaded = false;

  @override
  void initState() {
    _futureInfo = widget.model.initUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Margin.middle.w, right: Margin.middle.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
              future: _futureInfo,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                _isLoaded = snapshot.connectionState == ConnectionState.done;

                return Stack(
                  children: [
                    _loadingPlaceholder(),
                    _userInfo(),
                  ],
                );
              }),
          SizedBox(
            height: Margin.middle.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _roundedButton(
                  title: "action.edit".tr(),
                  onTap: () =>
                      _futureInfo.whenComplete(() => _goToUserEditPage()),
                  backgroundColor: context.surface,
                  textColor: context.onSurface),
              _roundedButton(
                  title: "action.log_out".tr(),
                  onTap: () => widget.model.logoutFromAccount(context),
                  backgroundColor: context.primary,
                  textColor: context.onPrimary),
            ],
          )
        ],
      ),
    );
  }

  Widget _roundedButton({
    required String title,
    required VoidCallback onTap,
    required Color textColor,
    required Color backgroundColor,
  }) {
    return AnimatedGestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radiuss.circle),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: Paddings.small_bigger,
            horizontal: Paddings.middle_bigger,
          ),
          child: Text(
            title,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: Dimens.text_normal),
          ),
        ));
  }

  Widget _loadingPlaceholder() {
    return AnimatedOpacity(
      opacity: _isLoaded ? 0 : 1,
      duration: AppDurations.milliseconds_short,
      child: Shimmer.fromColors(
        baseColor: context.surface.withOpacity(.6),
        highlightColor: context.surface,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                height: Dimens.avatar_photo_size,
                width: Dimens.avatar_photo_size,
                color: context.surface,
              ),
            ),
            SizedBox(
              width: Margin.middle.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 29.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: context.surface,
                      borderRadius: BorderRadius.all(Radiuss.small_smaller)),
                ),
                SizedBox(
                  height: Margin.small.h,
                ),
                Container(
                  height: 16.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      color: context.surface,
                      borderRadius: BorderRadius.all(Radiuss.small_smaller)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _userInfo() {
    return AnimatedOpacity(
      opacity: _isLoaded ? 1 : 0,
      duration: AppDurations.milliseconds_middle,
      child: _isLoaded
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Dimens.avatar_photo_size,
                  width: Dimens.avatar_photo_size,
                  child: ClipOval(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft,
                      child: Image.network(widget.model.userInfo.photoURL ??
                          widget.model.devSettings.emptyPhotoURL),
                    ),
                  ),
                ),
                SizedBox(width: Margin.middle.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AutoSizeText(
                        widget.model.userInfo.name ?? "profile.empty_name".tr(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: context.surface,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimens.text_big_smaller),
                      ),
                      Text(
                        widget.model.userInfo.email ??
                            "profile.empty_email".tr(),
                        style: TextStyle(
                            color: context.surface,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimens.text_small_bigger),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Container(),
    );
  }

  _goToUserEditPage() async {
    var result = await Routes.showBottomUserEditPage(context,
        userInfo: widget.model.userInfo, devSettings: widget.model.devSettings);

    if (result != null) {
      widget.model.userInfo = result;
      setState(() {});
    }
  }
}
