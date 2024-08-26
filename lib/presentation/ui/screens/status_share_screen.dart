import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/app/utility/app_font_style.dart';
import 'package:socialive/presentation/controllers/navigation/home/status_share_controller.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

class StatusShareScreen extends StatefulWidget {
  final String statusImage;
  const StatusShareScreen({super.key, required this.statusImage});

  @override
  State<StatusShareScreen> createState() => _StatusShareScreenState();
}

class _StatusShareScreenState extends State<StatusShareScreen> {
  final StatusShareController _statusShareController =
      Get.put(StatusShareController());
  Color _backgroundColor = AppColors.activeBottomNevItemColor;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final imageProvider = FileImage(File(widget.statusImage));
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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onScaleStart: (details) {
                      _statusShareController.previousScale.value =
                          _statusShareController.scale.value;
                      _statusShareController.previousPosition.value =
                          details.focalPoint -
                              _statusShareController.position.value;
                    },
                    onScaleUpdate: (details) {
                      _statusShareController.scale.value =
                          _statusShareController.previousScale.value *
                              details.scale;
                      _statusShareController.position.value =
                          details.focalPoint -
                              _statusShareController.previousPosition.value;
                    },
                    child: Transform.scale(
                      scale: _statusShareController.scale.value,
                      child: Transform.translate(
                        offset: _statusShareController.position.value,
                        child: SizedBox(
                          height: size.height,
                          child: Image.file(
                            File(widget.statusImage),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            backBtn(),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _statusShareController.reset,
                                  child: Icon(
                                    Icons.undo_rounded,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                const Text(
                                  "Undo",
                                  style: AppFontStyle.satoshi400S14,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.75),
                        elevatedBtn(
                            btnName: "Share",
                            onPressed: () => _statusShareController.shareStatus(
                                statusImage: widget.statusImage)),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
