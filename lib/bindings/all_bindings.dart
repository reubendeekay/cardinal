import 'package:get/get.dart';
import 'package:real_estate/controllers/auth_controller.dart';
import 'package:real_estate/controllers/property_controller.dart';
import 'package:real_estate/controllers/user_controller.dart';

class AllControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    /* Normally, Get.lazyPut loads dependencies only one time, which means that if the
    * route gets removed, and created again,
    * Get.lazyPut will not load them again. This default behavior might be preferable
    * in some cases while for others, we have the fenix property.*/
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut(() => PropertyController(), fenix: true);
  }
}
