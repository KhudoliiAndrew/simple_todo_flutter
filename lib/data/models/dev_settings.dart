import 'package:tasks_go_brr/resources/constants.dart';

class DevSettings {
  late String emptyPhotoURL;
  late String privacyPolicyURL;

  DevSettings();

  DevSettings.fromMapObject(Map<String, dynamic> map) {
    emptyPhotoURL = map[DevSettingsFields.EMPTY_PHOTO_URL];
    privacyPolicyURL = map[DevSettingsFields.PRIVACY_POLICY_URL];
  }
}
