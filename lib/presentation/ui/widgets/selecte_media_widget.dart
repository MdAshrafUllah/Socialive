import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/ui/widgets/images_selection/empty_media_widget.dart';

class SelectedMediaWidget extends StatelessWidget {
  const SelectedMediaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageSelectionController controller = Get.find();

    return Obx(() {
      if (controller.selectedMedia.isEmpty) {
        return const EmptyMediaView();
      } else if (controller.selectedMedia.length == 1) {
        return FutureBuilder<Uint8List?>(
          future: controller.selectedMedia[0]
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
        return CarouselSlider(
          items: controller.selectedMedia.map((media) {
            return FutureBuilder<Uint8List?>(
              future:
                  media.thumbnailDataWithSize(const ThumbnailSize(400, 400)),
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
          ),
        );
      }
    });
  }
}
