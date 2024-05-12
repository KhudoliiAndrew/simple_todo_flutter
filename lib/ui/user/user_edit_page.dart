import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_go_brr/data/models/dev_settings.dart';
import 'package:tasks_go_brr/data/models/user_info/user_info.dart';
import 'package:tasks_go_brr/resources/constants.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/resources/icons/icons.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/ui/custom/input_field_rounded.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/ui/user/user_edit_view_model.dart';
import 'package:tasks_go_brr/ui/user/widgets/delete_confirmation.dialog.dart';

import 'widgets/icon_rounded.button.dart';
import 'widgets/photo.widget.dart';

class UserEditPage extends StatefulWidget {
  final UserInfo userInfo;
  final DevSettings devSettings;

  const UserEditPage(
      {Key? key, required this.userInfo, required this.devSettings})
      : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final UserEditViewModel _model = UserEditViewModel();

  final TextEditingController _cntrlTitle = TextEditingController();
  final _formKeyTitle = GlobalKey<FormState>();

  @override
  void initState() {
    _model.userInfo = widget.userInfo;
    _model.devSettings = widget.devSettings;

    _setListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.only(
            topLeft: Radiuss.middle, topRight: Radiuss.middle),
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: Margin.middle_smaller.h,
        ),
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Margin.middle),
              child: Row(
                children: [
                  IconRoundedButton(
                      backgroundColor: context.surfaceAccent,
                      iconColor: context.onSurface,
                      icon: IconsC.back,
                      onTap: () => Routes.back(context)),
                  Expanded(
                    child: Container(),
                  ),
                  IconRoundedButton(
                    backgroundColor: context.primary,
                    iconColor: context.onPrimary,
                    icon: IconsC.check,
                    onTap: () async {
                      if (!_formKeyTitle.currentState!.validate()) return;

                      await _model.updateInfo();
                      Routes.back(context, result: _model.userInfo);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Margin.small.h,
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PhotoWidget(model: _model),
                  SizedBox(
                    height: Margin.middle.h,
                  ),
                  _titleOfCategory(text: "profile.name".tr()),
                  SizedBox(
                    height: Margin.small.h,
                  ),
                  _inputField(
                    label: "profile.name".tr(),
                    maxLines: 1,
                    textController: _cntrlTitle,
                    formKey: _formKeyTitle,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "error.title_cant_be_empty".tr();
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: Margin.middle.h),
                  IconRoundedButton(
                    backgroundColor: context.error,
                    icon: IconsC.delete,
                    iconColor: context.onSurface,
                    text: "profile.delete_all".tr(),
                    alignment: Alignment.centerRight,
                    onTap: () => _showDeleteConfirmationDialog(),
                  ),
                  SizedBox(height: Margin.middle.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
      {Key? formKey,
      required String label,
      required int maxLines,
      required TextEditingController textController,
      VoidCallback? onTap,
      IconData? buttonIcon,
      bool? shouldUnfocus,
      FormFieldValidator<String>? validator}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: Margin.middle,
      ),
      child: InputFieldRounded(
        formKey: formKey ?? null,
        labelText: label,
        maxLines: maxLines,
        textController: textController,
        borderColor: context.primary,
        textColor: context.onSurface,
        labelUnselectedColor: context.onSurfaceAccent,
        buttonIcon: buttonIcon ?? null,
        onTap: onTap,
        shouldUnfocus: shouldUnfocus ?? null,
        validator: validator ?? null,
      ),
    );
  }

  Widget _titleOfCategory({required String text}) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: Margin.middle),
      child: Text(
        text,
        style: TextStyle(
          color: context.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: Dimens.text_normal,
        ),
      ),
    );
  }

  _setListeners() {
    _cntrlTitle
      ..addListener(() => _model.userInfo.name = _cntrlTitle.text)
      ..text = _model.userInfo.name ?? Constants.EMPTY_STRING;
  }

  _showDeleteConfirmationDialog() async {
    final result = await showDialog(
      context: context,
      builder: (contextDialog) => DeleteConfirmationDialog(),
    );

    if(result == "delete") {
      _model.deleteAll(context);
    }
  }
}
