import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/components/detail_card.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, this.phoneNumber});
  final PhoneNumberVerificationModel? phoneNumber;

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
        automaticallyImplyLeading: true,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const TextTitle(
                    title: 'OTP Verification',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Enter your 6 digit OTP sent to ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '+91${widget.phoneNumber?.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      Pinput(
                        controller: otpController,
                        onChanged: (value) {
                          otpDigitCount.value = value.length;
                        },
                        length: 6,
                        showCursor: true,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    onPress: () async {
                      return await showDialog(
                        context: context,
                        builder: (context) {
                          return DetailCard(
                            phoneNumberVerificationModel:
                                PhoneNumberVerificationModel(
                                    otp: otpController.text,
                                    phoneNumber:
                                        widget.phoneNumber!.phoneNumber),
                          );
                        },
                      );
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
