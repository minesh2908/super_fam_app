import 'package:flutter/material.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/views/dashbaord/screens/home_page.dart';
import 'package:super_fam_app/views/registration/screens/otp_screen.dart';
import 'package:super_fam_app/views/registration/screens/phone_number_screen.dart';
import 'package:super_fam_app/views/registration/screens/user_details_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.phoneNumberScreen:
        return MaterialPageRoute(
          builder: (context) => const PhoneNumberScreen(),
        );
      case RoutesName.otpScreen:
        final args = setting.arguments! as PhoneNumberVerificationModel;

        return MaterialPageRoute(
          builder: (context) => OTPScreen(
            phoneNumber: args,
          ),
        );
      case RoutesName.userDetailScreen:
        final args = setting.arguments as PhoneNumberVerificationModel?;
        return MaterialPageRoute(
          builder: (context) => UserDetailScreen(
            phoneNumber: args,
          ),
        );
      case RoutesName.homePageScreen:
        return MaterialPageRoute(builder: (context) => const HomePageScreen());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Text('Something went wrong'),
            );
          },
        );
    }
  }
}
