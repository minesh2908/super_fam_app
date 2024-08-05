class PhoneNumberVerificationModel {
  final String? phoneNumber;
  final String? otp;

  PhoneNumberVerificationModel({this.phoneNumber, this.otp});

  PhoneNumberVerificationModel copyWith({String? phoneNumber, String? otp}) {
    return PhoneNumberVerificationModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
    );
  }
}
