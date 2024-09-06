import 'package:super_fam_app/model/user_model.dart';

class PhoneNumberVerificationModel {
  PhoneNumberVerificationModel({this.phoneNumber, this.otp, this.userModel});
  final String? phoneNumber;
  final String? otp;
  final UserModel? userModel;

  PhoneNumberVerificationModel copyWith({String? phoneNumber, String? otp}) {
    return PhoneNumberVerificationModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      userModel: userModel ?? userModel,
    );
  }
}
