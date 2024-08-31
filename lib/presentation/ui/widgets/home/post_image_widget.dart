import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/controllers/timeline_post_image_controller.dart';

class TimelinePostImage extends StatelessWidget {
  final List<String> postImage;
  final controller = Get.find<TimelinePostController>();

  TimelinePostImage({super.key, required this.postImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 327,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.textLightColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CarouselSlider(
                  items: postImage.map((imageUrl) {
                    return Builder(builder: (BuildContext context) {
                      return Image(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      controller.setCurrentIndex(index);
                    },
                  ),
                ),
                if (postImage.length > 1)
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: postImage.map((url) {
                          int index = postImage.indexOf(url);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 10),
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                color: controller.currentIndex.value == index
                                    ? AppColors.primaryColor
                                    : AppColors.transparentColor,
                              ),
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.foregroundColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
