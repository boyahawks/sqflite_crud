import 'package:get/get.dart';
import 'package:sakura_test_bayuh/main.dart';
import 'package:sakura_test_bayuh/modules/auth/auth.dart';
import 'package:sakura_test_bayuh/modules/student/student.dart';
// import 'package:sakura_test_bayuh/modules/auth/auth.dart';
// import 'package:sakura_test_bayuh/modules/weather/weather.dart';

class Routes {
  static routeTo({required String type, dynamic data}) {}

  static routeOff({required String type, dynamic data}) {
    if (type == "login") {
      Get.offAll(
        AuthLogin(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "student") {
      Get.offAll(
        const Student(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    } else if (type == "splash") {
      Get.offAll(
        const SplashScreen(),
        duration: const Duration(milliseconds: 300),
        transition: Transition.leftToRightWithFade,
      );
    }
  }
}
