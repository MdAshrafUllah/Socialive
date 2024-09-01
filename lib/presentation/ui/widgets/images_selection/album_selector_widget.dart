import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/images_selection_controller.dart';
import 'package:socialive/presentation/ui/utility/assets_path.dart';

class AlbumSelector extends StatelessWidget {
  const AlbumSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadContentController = Get.find<ImageSelectionController>();
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal:
              BorderSide(color: AppColors.inputFieldBorderColor, width: 1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Obx(() => DropdownButton<AssetPathEntity>(
                  value: uploadContentController.currentAlbum.value,
                  isExpanded: false,
                  underline: const SizedBox(),
                  icon: SvgPicture.asset(AssetsPath.downArrow),
                  onChanged: (AssetPathEntity? newValue) async {
                    if (newValue != null) {
                      await uploadContentController.loadMedia(newValue);
                      uploadContentController.currentAlbum.value = newValue;
                    }
                  },
                  items: uploadContentController.albums
                      .map<DropdownMenuItem<AssetPathEntity>>(
                          (AssetPathEntity album) {
                    return DropdownMenuItem<AssetPathEntity>(
                      value: album,
                      child: SizedBox(
                        width: 100,
                        child: Text(album.name,
                            maxLines: 1, style: AppFontStyle.satoshi700S18),
                      ),
                    );
                  }).toList(),
                )),
            const Spacer(),
            Obx(() => GestureDetector(
                  onTap: () => uploadContentController.toggleSelectionMode(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: uploadContentController.isMultipleSelected.value
                          ? AppColors.primaryColor
                          : AppColors.inputFieldBorderColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AssetsPath.multipleSelect,
                            colorFilter: ColorFilter.mode(
                              uploadContentController.isMultipleSelected.value
                                  ? AppColors.foregroundColor
                                  : AppColors.secondaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Multiple Select",
                            style:
                                uploadContentController.isMultipleSelected.value
                                    ? AppFontStyle.satoshi700S16C
                                    : AppFontStyle.satoshi700S16,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
