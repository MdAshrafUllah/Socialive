import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialive/app/utility/app_colors.dart';
import 'package:socialive/presentation/ui/widgets/button_widget.dart';

class StatusViewScreen extends StatefulWidget {
  final List<String> statusImage;
  const StatusViewScreen({super.key, required this.statusImage});

  @override
  State<StatusViewScreen> createState() => _StatusViewScreenState();
}

class _StatusViewScreenState extends State<StatusViewScreen> {
  Color _backgroundColor = AppColors.activeBottomNevItemColor;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final imageProvider = NetworkImage(widget.statusImage[0]);
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
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Center(
                child: Image.network(
                  (widget.statusImage[0]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
                Align(alignment: Alignment.centerLeft, child: backBtn()),
                SizedBox(height: size.height * 0.9),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
