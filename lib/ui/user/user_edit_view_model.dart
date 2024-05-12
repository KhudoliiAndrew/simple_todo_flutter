import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasks_go_brr/data/models/dev_settings.dart';
import 'package:tasks_go_brr/data/models/root_data.dart';
import 'package:tasks_go_brr/data/models/user_info/user_info.dart';
import 'package:tasks_go_brr/data/repositories/remote/user_info_repository.dart';
import 'package:tasks_go_brr/data/repositories/storage_repository.dart';
import 'package:tasks_go_brr/resources/routes.dart';

class UserEditViewModel {
  UserInfoRepository _repo = UserInfoRepository();
  StorageRepository _storage = StorageRepository();

  late UserInfo userInfo;
  late DevSettings devSettings;

  updateInfo() async {
    await _repo.updateUserInfo(userInfo);
  }

  Future deleteAll(BuildContext context) async {
    final rootContext =
        Provider.of<RootData>(context, listen: false).rootContext;

    if (await _repo.deleteAll(userInfo))
      Routes.toSplashPage(rootContext);
  }

  Future pickAndUploadPhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
      await _uploadImageToFirebase(pickedFile);
  }

  Future _uploadImageToFirebase(XFile image) async {
    userInfo.photoURL =
        await _storage.uploadUserPhoto(userInfo.id!, File(image.path));
  }
}