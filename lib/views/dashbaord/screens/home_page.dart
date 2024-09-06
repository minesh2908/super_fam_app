import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:super_fam_app/components/custom_button.dart';
import 'package:super_fam_app/components/custom_text.dart';
import 'package:super_fam_app/components/drawer_container.dart';
import 'package:super_fam_app/model/phone_verification_model.dart';
import 'package:super_fam_app/model/user_model.dart';
import 'package:super_fam_app/routes/routes_names.dart';
import 'package:super_fam_app/services/get_user_data.dart';
import 'package:super_fam_app/utils/permission.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  //
  Uint8List? bytes;
  final double _progress = 0;
  bool _isDownloading = false;
  Future<void> downloadImage(Uint8List bytes, BuildContext context) async {
    try {
      final hasPermission = await requestStoragePermission();
      if (hasPermission) {
        final tempDir = await getTemporaryDirectory();
        // log(tempDir.path);
        final file = File('${tempDir.path}/image_${DateTime.now()}.png');
        await file.writeAsBytes(bytes);
        // log(fullPath);

        final success = await SaverGallery.saveImage(
          bytes,
          name: 'image_${DateTime.now()}',
          androidExistNotSave: false,
        );

        if (success.isSuccess) {
          setState(() {
            _isDownloading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image saved to gallery!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save image to gallery!')),
          );
        }
        log(success.toString());
      }
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      log('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerContainer(),
      appBar: AppBar(
        title: Text(
          'Poster App',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.person,
                    size: 32.h,
                    color: Colors.orange.shade800,
                  ),
                );
              },
            ),
          ),
        ],
        backgroundColor: Colors.grey.shade200,
      ),
      body: PageView.builder(
        key: const Key('value'),
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (BuildContext context, index) {
          final widgetController = WidgetsToImageController();
          return Padding(
            key: Key('Padding_$index'),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 370.h,
                  child: WidgetsToImage(
                    key: Key('Image $index'),
                    controller: widgetController,
                    child: index % 2 == 0
                        ? Stack(
                            children: <Widget>[
                              Container(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    'assets/images/posterImage.png',
                                    fit: BoxFit.cover,
                                    height: 400.h,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 310.h,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60.h,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                              Positioned(
                                right: 10.w,
                                top: 236.h,
                                child: Image.file(
                                  File(getImage()),
                                  width: 100.w,
                                  height: 140.h,
                                ),
                              ),
                              Positioned(
                                right: 130.w,
                                top: 320.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextPosterName(
                                      title: getUserName(),
                                    ),
                                    TextPosterDesignation(
                                      title: getDesignation(),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 130.w,
                                top: 380.h,
                                child: const Text('data'), // Remove this Row
                              ),
                            ],
                          )
                        : Stack(
                            children: <Widget>[
                              Container(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    'assets/images/posterImage.png',
                                    fit: BoxFit.cover,
                                    height: 400.h,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 310.h,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60.h,
                                  color: Colors.orange.shade800,
                                ),
                              ),
                              Positioned(
                                left: 10.w,
                                top: 236.h,
                                child: Image.file(
                                  File(getImage()),
                                  width: 100.w,
                                  height: 140.h,
                                ),
                              ),
                              Positioned(
                                left: 130.w,
                                top: 320.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextPosterName(
                                      title: getUserName(),
                                    ),
                                    TextPosterDesignation(
                                      title: getDesignation(),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 130.w,
                                top: 380.h,
                                child: const Text('data'), // Remove this Row
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    // Move this Row outside of the Stack
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PosterButton(
                        title: 'Edit',
                        icon: Icons.edit,
                        color: Colors.redAccent,
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
                      ),
                      if (_isDownloading)
                        const CircularProgressIndicator()
                      else
                        PosterButton(
                          title: 'Download',
                          icon: Icons.download,
                          color: Colors.blueAccent,
                          onTap: () async {
                            setState(() {
                              _isDownloading = true;
                            });
                            bytes = await widgetController.capture();
                            await downloadImage(
                              bytes!,
                              context,
                            );
                            setState(() {
                              _isDownloading = false;
                            });
                          },
                        ),
                      PosterButton(
                        title: 'share',
                        icon: Icons.share,
                        color: Colors.green,
                        onTap: () async {
                          bytes = await widgetController.capture();
                          await Share.shareXFiles([
                            XFile.fromData(
                              bytes!,
                              mimeType: 'image/png',
                            ),
                          ]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
