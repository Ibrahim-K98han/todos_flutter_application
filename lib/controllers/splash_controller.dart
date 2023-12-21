import 'package:get/get.dart';
import 'package:todos_flutter_application/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(Routes.login);
    });
  }
}
