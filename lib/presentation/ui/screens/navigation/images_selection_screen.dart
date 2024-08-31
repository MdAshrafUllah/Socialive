import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/ui/screens/navigation/share_content_screen.dart';
import 'package:socialive/presentation/ui/widgets/images_selection/album_selector_widget.dart';
import 'package:socialive/presentation/ui/widgets/custom_app_bar.dart';
import 'package:socialive/presentation/ui/widgets/images_selection/media_grid_view.dart';
import 'package:socialive/presentation/ui/widgets/images_selection/selected_media_widget.dart';

class ImagesSelectionScreen extends StatelessWidget {
  const ImagesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadContentController = Get.find<ImageSelectionController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            customAppBar(
              title: "New Post",
              isBackButtonEnable: true,
              showAction: true,
              actionTitle: "Next",
              onTapAction: () {
                if (uploadContentController.selectedMedia.isNotEmpty) {
                  Get.off(() => ShareContentScreen(
                        selectedImages: uploadContentController.selectedMedia,
                      ));
                }
              },
              clearData: uploadContentController.clearSelectedMedia,
            ),
            const Expanded(child: SelectedMediaWidget()),
            const AlbumSelector(),
            const Expanded(child: MediaGrid()),
          ],
        ),
      ),
    );
  }
}
