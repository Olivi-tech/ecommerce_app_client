import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/constants/app_colors.dart';
import 'package:shop_app/providers/image_picker_provider.dart';
import 'package:shop_app/utils/app_utils.dart';
import 'package:shop_app/utils/pick_image.dart';

import '../../../db_services/cloud_firestore.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePickerProvider imagePickerProvider =
        Provider.of<ImagePickerProvider>(context, listen: false);
    return SizedBox(
      height: 115,
      width: 115,
      child: Consumer<ImagePickerProvider>(
        builder: (context, value, child) {
          return Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: imagePickerProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : imagePickerProvider.pickImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                File(imagePickerProvider.getImage),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Image.asset(
                                  'assets/images/Profile Image.png'))),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () async {
                      String image = await PickFile.pickImage(
                          imageSource: ImageSource.gallery);
                      imagePickerProvider.setImage = image;
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppColors.darkGrey,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
