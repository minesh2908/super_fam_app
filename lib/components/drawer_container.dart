import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/services/get_user_data.dart';
import 'package:super_fam_app/services/shared_prefrence.dart';

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 32.h,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 32,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(File(getImage())),
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  TextHeadingController(title: getUserName()),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesName.userDetailScreen,
                        arguments: PhoneNumberVerificationModel(
                          userModel: UserModel(
                            name: getUserName(),
                            phoneNumber: getPhoneNum(),
                            profilePic: getImage(),
                            designation: getDesignation(),
                            state: getState(),
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(),
            DrawerTile(
              onTap: () async {
                await AppPrefHelper.setLoggedIn(loggedIn: false);
                await Navigator.pushReplacementNamed(
                  context,
                  RoutesName.phoneNumberScreen,
                );
              },
              title: 'Log Out',
              icon: Icons.logout,
            ),
            DrawerTile(
              onTap: () async {
                await AppPrefHelper.setLoggedIn(loggedIn: false);
                await AppPrefHelper.signOut();
                await Navigator.pushReplacementNamed(
                  context,
                  RoutesName.phoneNumberScreen,
                );
              },
              title: 'Delete',
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    required this.onTap,
    required this.title,
    required this.icon,
    super.key,
  });
  final Function()? onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.zero,
        height: 40,
        width: 60,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
