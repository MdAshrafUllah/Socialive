import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDataClear {
  static Future<void> deleteCacheDir() async {
    Directory tempDir = await getTemporaryDirectory();

    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<void> deleteAppDir() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();

    if (await appDocDir.exists()) {
      await appDocDir.delete(recursive: true);
    }
  }
}
