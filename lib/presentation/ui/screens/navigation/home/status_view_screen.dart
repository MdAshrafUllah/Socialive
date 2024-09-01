import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_view_screen_controller.dart';
import 'package:socialive/presentation/ui/widgets/show_alert_dialog.dart';

class StatusViewScreen extends StatefulWidget {
  final List<String> statusImage;
  final bool? firstIndex;
  const StatusViewScreen(
      {super.key, required this.statusImage, this.firstIndex});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  late StatusViewScreenController _statusViewController;
  Color _backgroundColor = AppColors.activeBottomNevItemColor;

  @override
  void initState() {
    super.initState();
    _statusViewController =
        Get.put(StatusViewScreenController(widget.statusImage));
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final imageProvider = NetworkImage(
        widget.statusImage[_statusViewController.currentIndex.value]);
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);

    setState(() {
      _backgroundColor =
          paletteGenerator.dominantColor?.color ?? _backgroundColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        onTap: () {
          _statusViewController.showNextImage();
          _extractDominantColor();
        },
        onLongPress: () {
          _statusViewController.holdProgress();
        },
        onLongPressUp: () {
          _statusViewController.resumeProgress();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Center(
                child: Obx(() {
                  if (_statusViewController.statusImages.isNotEmpty &&
                      _statusViewController.currentIndex.value <
                          _statusViewController.statusImages.length) {
                    return Image(
                      image: CachedNetworkImageProvider(
                          _statusViewController.statusImages[
                              _statusViewController.currentIndex.value]),
                      fit: BoxFit.fitWidth,
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
            Column(
              children: [
                SizedBox(height: size.height * 0.07),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: List.generate(
                          _statusViewController.statusImages.length, (index) {
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(20),
                              minHeight: 2,
                              value: _statusViewController.currentIndex.value >
                                      index
                                  ? 1.0
                                  : (_statusViewController.currentIndex.value ==
                                          index
                                      ? _statusViewController.progress.value
                                      : 0.0),
                              valueColor:
                                  _statusViewController.currentIndex.value ==
                                          index
                                      ? AlwaysStoppedAnimation<Color>(
                                          AppColors.primaryColor)
                                      : AlwaysStoppedAnimation<Color>(
                                          AppColors.foregroundColor),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const Spacer(),
                if (widget.firstIndex == true)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              height: 15,
                              onTap: () {
                                _statusViewController.holdProgress();
                                showAlertDialog(
                                  title: "Do you want to Delete this Status?",
                                  elevatedBtnName: "Delete",
                                  textBtnName: "Cancel",
                                  onElevatedBtnPressed: () {
                                    _statusViewController.deleteStatus(
                                        statusImage:
                                            _statusViewController.statusImages[
                                                _statusViewController
                                                    .currentIndex.value]);
                                    Get.back();
                                  },
                                  skipBtn: true,
                                  onTextBtnPressed: () {
                                    Get.back();
                                    _statusViewController.resumeProgress();
                                  },
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: AppFontStyle.satoshi400S12,
                              ),
                            ),
                          ];
                        },
                        child: Icon(
                          Icons.more_horiz_rounded,
                          color: AppColors.foregroundColor,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
