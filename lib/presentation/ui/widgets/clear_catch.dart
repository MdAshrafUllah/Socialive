import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteCacheDir() async {
  Directory tempDir = await getTemporaryDirectory();

  if (tempDir.existsSync()) {
    tempDir.deleteSync(recursive: true);
  }

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

Future<void> deleteAppDir() async {
  Directory appDocDir = await getApplicationDocumentsDirectory();

  if (appDocDir.existsSync()) {
    appDocDir.deleteSync(recursive: true);
  }
}
