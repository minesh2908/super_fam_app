import 'package:flutter/material.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({
    super.key,
    required this.phoneNumberVerificationModel,
  });

  final PhoneNumberVerificationModel phoneNumberVerificationModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('User Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextHeadingController(title: 'Phone Number:'),
          TextContentUI(title: '${phoneNumberVerificationModel.phoneNumber}'),
          const TextHeadingController(title: 'OTP:'),
          TextContentUI(title: '${phoneNumberVerificationModel.otp}'),
          const SizedBox(height: 20),
          CustomButton(
            buttonTitle: 'Go to Phone Verification',
            onPress: () {
              Navigator.pushReplacementNamed(context, 'phoneNumberScreen');
            },
          ),
        ],
      ),
    );
  }
}
