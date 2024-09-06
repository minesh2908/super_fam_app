import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/components/custom_text_field.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/phoneImage.png',
              width: MediaQuery.of(context).size.width * 0.50,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 20.h,
            ),
            const TextTitle(title: 'Phone Verification'),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter your 10 digit Phone Number to Sign In!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Form(
              key: _formKey,
              child: CustomTextField(
                keyboardType: TextInputType.number,
                controller: phoneNumberController,
                label: 'Enter Phone Number',
                maxLength: 10,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number cannot be empty';
                  } else if (value.length != 10) {
                    return 'Phone Number must be 10 digits';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              onPress: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  await Navigator.pushNamed(
                    context,
                    RoutesName.otpScreen,
                    arguments: PhoneNumberVerificationModel(
                      phoneNumber: phoneNumberController.text,
                    ),
                  );
                }
              },
              buttonTitle: 'Send OTP',
            ),
          ],
        ),
      ),
    );
  }
}
