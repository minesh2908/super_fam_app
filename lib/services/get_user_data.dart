import 'dart:convert';

import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/services/shared_prefrence.dart';

String getUserName() {
  final response = AppPrefHelper.getUserModal();
  final modal = UserModel.fromJson(
    jsonDecode(response) as Map<String, dynamic>,
  );
  final userName = modal.name;
  return userName!;
}

String getDesignation() {
  final response = AppPrefHelper.getUserModal();
  final modal = UserModel.fromJson(
    jsonDecode(response) as Map<String, dynamic>,
  );
  final userName = modal.designation;
  return userName!;
}

String getImage() {
  final response = AppPrefHelper.getUserModal();
  final modal = UserModel.fromJson(
    jsonDecode(response) as Map<String, dynamic>,
  );
  final image = modal.profilePic;
  return image!;
}

String? getPhoneNum() {
  final response = AppPrefHelper.getUserModal();
  final modal = UserModel.fromJson(
    jsonDecode(response) as Map<String, dynamic>,
  );
  final phoneNum = modal.phoneNumber;
  return phoneNum;
}

String getState() {
  final response = AppPrefHelper.getUserModal();
  final modal = UserModel.fromJson(
    jsonDecode(response) as Map<String, dynamic>,
  );
  final state = modal.state;
  return state!;
}
