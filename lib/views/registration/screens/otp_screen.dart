import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/services/shared_prefrence.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({required this.phoneNumber, super.key});
  final PhoneNumberVerificationModel phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<int> otpDigitCount = ValueNotifier<int>(0);
  final otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: otpDigitCount,
        builder: (context, value, _) {
          return Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: SingleChildScrollView(
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
                  const TextTitle(
                    title: 'OTP Verification',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter your 6 digit OTP sent to ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '+91${widget.phoneNumber.phoneNumber}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Text('Enter any 6 digit number for now!'),
                  SizedBox(
                    height: 25.h,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Pinput(
                          controller: otpController,
                          onChanged: (value) {
                            otpDigitCount.value = value.length;
                          },
                          length: 6,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPress: () {
                      final response = AppPrefHelper.getUserModal();
                      final modal = UserModel.fromJson(
                        jsonDecode(response) as Map<String, dynamic>,
                      );

                      if (modal.phoneNumber == widget.phoneNumber.phoneNumber) {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.homePageScreen,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.userDetailScreen,
                          arguments: PhoneNumberVerificationModel(
                            phoneNumber: widget.phoneNumber.phoneNumber,
                          ),
                        );
                      }
                    },
                    buttonTitle: 'LogIn',
                    otpLength: otpDigitCount.value,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
