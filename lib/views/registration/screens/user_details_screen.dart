import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/components/custom_text_field.dart';
import 'package:super_fam_app/components/detail_card.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/services/image_picker.dart';
import 'package:super_fam_app/views/registration/bloc/registration_bloc.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({
    this.phoneNumber,
    super.key,
  });
  final PhoneNumberVerificationModel? phoneNumber;

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  XFile? returnedImage;
  @override
  void initState() {
    // TODO: implement initState
    stateController.text = 'Madhya Pradesh';
    if (widget.phoneNumber!.userModel != null) {
      stateController.text = widget.phoneNumber!.userModel!.state!;
      designationController.text = widget.phoneNumber!.userModel!.designation!;
      nameController.text = widget.phoneNumber!.userModel!.name!;
      returnedImage = XFile(widget.phoneNumber!.userModel!.profilePic!);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.phoneNumber!.userModel != null
                ? 'Edit Profile'
                : 'Add Profile',
          ),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
          create: (context) => RegistrationBloc()..add(GetStateDataEvent()),
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is UserDataSavedSuccessState) {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.homePageScreen,
                );
              }
            },
            builder: (context, state) {
              if (state is RegistrationLoadedState) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                returnedImage =
                                    await PickImage().pickImageFromGallery();
                                setState(() {});
                              },
                              child: Container(
                                width: 80.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: returnedImage == null
                                      ? const Icon(
                                          Icons.person_add,
                                          size: 50,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.file(
                                            File(returnedImage!.path),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextHeadingController(
                                  title: 'Uplaod Your Photo',
                                ),
                                TextHeadingController(
                                  title: '(अपना फोटो यहाँ प्रति अपलोड करे)',
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextHeadingController(
                                title: 'Name : (आपका नाम)',
                              ),
                              CustomTextField(
                                controller: nameController,
                                label: 'Ex Manoj Senghani',
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name can not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              const TextHeadingController(
                                title: 'Designation : (आपका पड लिखे )',
                              ),
                              CustomTextField(
                                controller: designationController,
                                label: 'Owner of Drizzle Network',
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Designation can not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              const TextHeadingController(
                                title: 'Select Your State : (अपना राज्य चुनें)',
                              ),
                              CustomTextField(
                                controller: stateController,
                                label: '',
                                readOnly: true,
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DetailCard(
                                        searchStateController: stateController,
                                        stateData: state.stateModel!,
                                      );
                                    },
                                  );
                                  print(state.stateModel!.indiaStateList);
                                },
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'State can not be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          onPress: () {
                            if (returnedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Image can not be empty!'),
                                ),
                              );
                            }
                            if (_formKey.currentState!.validate() &&
                                returnedImage != null) {
                              context.read<RegistrationBloc>().add(
                                    AddUserDetailEvent(
                                      userDetail: UserModel(
                                        name: nameController.text,
                                        state: stateController.text,
                                        designation: designationController.text,
                                        phoneNumber:
                                            widget.phoneNumber!.phoneNumber,
                                        profilePic: returnedImage!.path,
                                      ),
                                    ),
                                  );
                            }
                          },
                          buttonTitle: 'Submit',
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
