import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialive/presentation/ui/screens/main_bottom_nev.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkedToken();
  }

  void _checkedToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      Get.offAll(() => const MainBottomNavigation());
    }
  }
}
