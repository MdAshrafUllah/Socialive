import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/controllers/share_content_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';
import 'package:socialive/presentation/ui/widgets/custom_app_bar.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

class ShareContentScreen extends StatefulWidget {
  final List<AssetEntity> selectedImages;

  const ShareContentScreen({
    super.key,
    required this.selectedImages,
  });

  @override
  State<ShareContentScreen> createState() => _ShareContentScreenState();
}

class _ShareContentScreenState extends State<ShareContentScreen> {
  final shareContentController = Get.find<ShareContentController>();
  final uploadContentController = Get.find<ImageSelectionController>();
  List<File> imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppBar(
                title: "New Post",
                isBackButtonEnable: true,
                showAction: true,
                actionTitle: "Post",
                onTapAction: () => showAlertDialog(
                  topIcons: Image.asset(AssetsPath.alert),
                  title: "Do you want to post?",
                  content:
                      "Your post will be shared by clicking Post Now. If you need to make changes, click Edit.",
                  elevatedBtnName: "Post Now",
                  textBtnName: "Edit",
                  skipBtn: true,
                  onElevatedBtnPressed: () {
                    uploadContentController.clearSelectedMedia();
                    Get.back();
                    if (imageFiles.isNotEmpty) {
                      shareContentController.shareCurrentUserPosts(
                          postImages: imageFiles);
                    }
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.selectedImages.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                imageFiles.isNotEmpty
                                    ? imageFiles[0]
                                    : File(''),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (widget.selectedImages.length > 1)
                          Container(
                            width: 100,
                            color: AppColors.activeBottomNevItemColor
                                .withOpacity(0.6),
                            child: Center(
                              child: Text(
                                "${widget.selectedImages.length - 1} More",
                                style: AppFontStyle.satoshi700S14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: shareContentController.postTextController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Write a caption',
                        ),
                        maxLines: null,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.inputFieldBorderColor,
                thickness: 1,
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadImages() async {
    final files = await Future.wait(widget.selectedImages.map(
      (image) async => image.file,
    ));

    setState(() {
      imageFiles = files.whereType<File>().toList();
    });
  }
}
