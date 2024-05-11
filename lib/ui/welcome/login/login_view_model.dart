import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasks_go_brr/data/models/dev_settings.dart';
import 'package:tasks_go_brr/data/repositories/remote/dev_settings_repository.dart';
import 'package:tasks_go_brr/data/repositories/remote/user_info_repository.dart';
import 'package:tasks_go_brr/resources/routes.dart';
import 'package:tasks_go_brr/utils/authentication.dart';
import 'package:tasks_go_brr/data/models/user_info/user_info.dart' as usr;

class LoginViewModel {
  UserInfoRepository _repo = UserInfoRepository();
  final DevSettingsRepository _repoSettings = DevSettingsRepository();

  DevSettings devSettings = DevSettings();

  init() async {
    devSettings = await _repoSettings.getDevSettings();
  }

  Future authUser(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser != null)
      Routes.toMainPage(context);
    else
      await loginWithGoogle(context);
  }

  loginWithGoogle(BuildContext context) async {
    User? user = await Authentication.signInWithGoogle(context: context);

    if (user != null) {
      addUserInfo(user);
      Routes.toMainPage(context);
    }
  }

  addUserInfo(User user) {
    _repo.addUserInfo(usr.UserInfo(
        id: user.uid,
        email: user.email,
        name: user.displayName,
        photoURL: user.photoURL));
  }

  openPrivacyPolicy(BuildContext context) async {
    Routes.showPrivacyPolicyPage(context, ppUrl: devSettings.privacyPolicyURL);

    //await Links.openLink(devSettings.privacyPolicyURL ?? AppInfo.URL_PRIVACY_POLICY);
  }
}