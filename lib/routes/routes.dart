import 'package:flutter/material.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/screens/otp_screen.dart';
import 'package:super_fam_app/screens/phone_number_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.phoneNumberScreen:
        return MaterialPageRoute(
            builder: (context) => const PhoneNumberScreen());
      case RoutesName.otpScreen:
        final args = setting.arguments as PhoneNumberVerificationModel?;

        return MaterialPageRoute(
            builder: (context) => OTPScreen(
                  phoneNumber: args,
                ));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Text('Something went wrong'),
          );
        });
    }
  }
}
