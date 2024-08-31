import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/ui/widgets/images_selection/empty_media_widget.dart';

class SelectedMediaWidget extends StatelessWidget {
  const SelectedMediaWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final uploadContentController = Get.find<ImageSelectionController>();
    return Obx(() {
      if (uploadContentController.selectedMedia.isEmpty) {
        return const EmptyMediaView();
      } else if (uploadContentController.selectedMedia.length == 1) {
        return FutureBuilder<Uint8List?>(
          future: uploadContentController.selectedMedia[0]
              .thumbnailDataWithSize(const ThumbnailSize(400, 400)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Image.memory(snapshot.data!);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      } else {
        return Stack(
          children: [
            CarouselSlider(
              items: uploadContentController.selectedMedia.map((media) {
                return FutureBuilder<Uint8List?>(
                  future: media
                      .thumbnailDataWithSize(const ThumbnailSize(400, 400)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Image.memory(snapshot.data!, fit: BoxFit.cover);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  uploadContentController.setCurrentIndex(index);
                },
              ),
            ),
            if (uploadContentController.selectedMedia.length > 1)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < uploadContentController.selectedMedia.length;
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Obx(() {
                            return Container(
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                color: uploadContentController
                                            .currentIndex.value ==
                                        i
                                    ? AppColors.primaryColor
                                    : AppColors.transparentColor,
                              ),
                              child: Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.foregroundColor,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        );
      }
    });
  }
}
