import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/edit_profile_screen_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';
import 'package:socialive/presentation/ui/widgets/text_field_widget.dart';
import 'package:socialive/presentation/ui/widgets/upload_image_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final EditProfileController _editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.07),
              backBtn(),
              SizedBox(height: height * 0.07),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => showUploadImageDialog(
                          fromCamera: _editProfileController
                              .profilePictureUploadFromCamera,
                          fromGallery: _editProfileController
                              .profilePictureUploadFromGallery),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.secondaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(() {
                          final image =
                              _editProfileController.selectedImage.value;
                          return image != null && image.path.isNotEmpty
                              ? Image.file(File(image.path))
                              : SvgPicture.asset(AssetsPath.add);
                        }),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Profile Picture',
                      style: AppFontStyle.satoshi700S18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Name',
                style: AppFontStyle.satoshi700S18,
              ),
              const SizedBox(height: 5),
              TextFieldWidget(
                prefixIcon: AssetsPath.person,
                controllerTE: _editProfileController.nameController,
                hint: _editProfileController.getNameHint(),
                validator: "Enter Your Name",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 8),
              const Text(
                'User Name',
                style: AppFontStyle.satoshi700S18,
              ),
              const SizedBox(height: 5),
              TextFieldWidget(
                prefixIcon: AssetsPath.person,
                controllerTE: _editProfileController.userNameController,
                hint: _editProfileController.getUserNameHint(),
                validator: "Enter Your User Name",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 8),
              const Text(
                'Email',
                style: AppFontStyle.satoshi700S18,
              ),
              const SizedBox(height: 5),
              TextFieldWidget(
                enabled: false,
                prefixIcon: AssetsPath.person,
                controllerTE: _editProfileController.emailController,
                hint: _editProfileController.getEmailHint(),
                validator: "Enter Your Email Address",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              elevatedBtn(
                btnName: "Update",
                onPressed: () {
                  _editProfileController.profileController.updateUserProfile();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
