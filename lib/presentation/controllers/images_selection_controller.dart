import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageSelectionController extends GetxController {
  RxList<AssetEntity> mediaList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> albums = <AssetPathEntity>[].obs;
  Rxn<AssetPathEntity> currentAlbum = Rxn<AssetPathEntity>();
  RxList<AssetEntity> selectedMedia = <AssetEntity>[].obs;
  RxBool isMultipleSelected = false.obs;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadAlbums();
  }

  Future<void> loadAlbums() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums.value = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(
              minHeight: 100,
              minWidth: 100,
            ),
          ),
          orders: [
            const OrderOption(
              type: OrderOptionType.createDate,
              asc: false,
            ),
          ],
        ),
      );

      if (albums.isNotEmpty) {
        currentAlbum.value = albums[0];
        await loadMedia(currentAlbum.value!);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  Future<void> loadMedia(AssetPathEntity album) async {
    var media = await album.getAssetListPaged(page: 0, size: 100);
    mediaList.value = media;
  }

  void onMediaSelect(AssetEntity media) {
    if (isMultipleSelected.value) {
      if (selectedMedia.contains(media)) {
        selectedMedia.remove(media);
      } else {
        selectedMedia.add(media);
      }
    } else {
      selectedMedia.clear();
      selectedMedia.add(media);
    }
  }

  void toggleSelectionMode() {
    isMultipleSelected.value = !isMultipleSelected.value;
    selectedMedia.clear();
  }

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void clearSelectedMedia() {
    toggleSelectionMode();
    selectedMedia.clear();
    isMultipleSelected.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    clearSelectedMedia();
  }
}
