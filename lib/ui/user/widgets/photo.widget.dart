import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/icons/icons.dart';
import 'package:tasks_go_brr/ui/user/user_edit_view_model.dart';

import 'icon_rounded.button.dart';

class PhotoWidget extends StatefulWidget {
  PhotoWidget({super.key, required this.model});

  final UserEditViewModel model;

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconRoundedButton(
          backgroundColor: context.surfaceAccent,
          icon: IconsC.delete,
          iconColor: context.onSurface,
          onTap: () => setState(() => widget.model.userInfo.photoURL = null),
        ),
        SizedBox(
          width: Margin.middle.w,
        ),
        Container(
          height: Dimens.avatar_photo_size_middle,
          width: Dimens.avatar_photo_size_middle,
          child: ClipOval(
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
              child: Image.network(
                  widget.model.userInfo.photoURL ?? widget.model.devSettings.emptyPhotoURL),
            ),
          ),
        ),
        SizedBox(width: Margin.middle.w),
        IconRoundedButton(
            backgroundColor: context.surfaceAccent,
            icon: IconsC.upload,
            iconColor: context.onSurface,
            onTap: () {
              widget.model.pickAndUploadPhoto().then((value) => setState(() {}));
            }),
      ],
    );
  }
}
