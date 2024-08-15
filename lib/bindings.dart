import 'package:get/get.dart';
import 'package:socialive/presentation/controllers/profile_screen_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ProfileScreenController(),fenix: true);
  }

}