import 'package:flutter/material.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';

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
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number cannot be empty';
                      } else if (value.length != 10) {
                        return 'Phone Number must be 10 digits';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPress: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.pushNamed(context, 'otpScreen',
                        arguments: PhoneNumberVerificationModel(
                            phoneNumber: phoneNumberController.text));
                  }
                },
                buttonTitle: 'Send OTP',
              )
            ],
          ),
        ),
      ),
    );
  }
}
