import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks_go_brr/resources/constants.dart';
import 'package:tasks_go_brr/resources/dimens.dart';
import 'package:tasks_go_brr/ui/welcome/login/login_view_model.dart';
import 'package:tasks_go_brr/resources/colors.dart';
import 'package:tasks_go_brr/ui/custom/animated_gesture_detector.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginViewModel _model = LoginViewModel();

  @override
  void initState() {
    _model.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginButton = AnimatedGestureDetector(
      onTap: () => _model.authUser(context),
      child: Container(
        decoration: BoxDecoration(
          color: context.primary,
          borderRadius: BorderRadius.all(Radiuss.middle),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Paddings.big.w,
          vertical: Paddings.small.h,
        ),
        child: Text(
          "action.log_in".tr(),
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Dimens.text_normal_bigger,
              color: context.onPrimary),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: context.background,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppInfo.IC_APP_FULL_PATH,
                  height: Dimens.app_icon_size,
                  width: Dimens.app_icon_size,
                ),
                SizedBox(
                  height: Margin.middle_smaller.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Margin.middle.w),
                  child: Text(
                    AppInfo.APP_NAME,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: context.onSurface,
                        fontSize: Dimens.text_big,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Margin.big.h,
                ),
                loginButton,
              ],
            ),
          ),
          Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.symmetric(horizontal: Margin.middle.w),
                  child: GestureDetector(
                    onTap: () => _model.openPrivacyPolicy(context),
                    child: RichText(
                      textAlign: TextAlign.center,
                      softWrap: true,
                      text: TextSpan(
                          text: "p_c.description".tr(),
                          children: [
                            TextSpan(
                                text: "p_c.privacy_policy".tr() + ".",
                                style: TextStyle(
                                    color: context.primary,
                                    fontWeight: FontWeight.w500))
                          ],
                          style: TextStyle(
                            color: context.onSurface,
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Margin.middle.h)
            ],
          )
        ],
      ),
    );
  }
}
