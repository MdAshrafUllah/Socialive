import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadContentController = Get.find<ImageSelectionController>();

    return Obx(() {
      return uploadContentController.mediaList.isEmpty
          ? const Center(child: Text("No media available"))
          : GridView.builder(
              padding: const EdgeInsets.only(top: 1),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: uploadContentController.mediaList.length,
              itemBuilder: (context, index) {
                return FutureBuilder<Uint8List?>(
                  future: uploadContentController.mediaList[index]
                      .thumbnailDataWithSize(const ThumbnailSize(200, 200)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return GestureDetector(
                        onTap: () => uploadContentController.onMediaSelect(
                            uploadContentController.mediaList[index]),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.memory(snapshot.data!,
                                  fit: BoxFit.cover),
                            ),
                            Obx(() {
                              bool isSelected = uploadContentController
                                  .selectedMedia
                                  .contains(
                                      uploadContentController.mediaList[index]);
                              return uploadContentController
                                      .isMultipleSelected.value
                                  ? Positioned(
                                      right: 8,
                                      bottom: 8,
                                      child: Icon(
                                        isSelected
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        color: isSelected
                                            ? AppColors.primaryColor
                                            : AppColors.foregroundColor,
                                      ),
                                    )
                                  : const SizedBox();
                            }),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                );
              },
            );
    });
  }
}
