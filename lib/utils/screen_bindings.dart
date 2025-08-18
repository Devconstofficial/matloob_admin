import 'package:get/get.dart';
import 'package:matloob_admin/screens/clicks_tracking_screen/controller/clicks_tracking_controller.dart';
import 'package:matloob_admin/screens/rfqs/controller/rfq_controller.dart';
import 'package:matloob_admin/screens/store_management/controller/store_controller.dart';
import 'package:matloob_admin/screens/user_management/controller/user_controller.dart';

import '../screens/auth/controller/auth_controller.dart';
import '../screens/dashboard_screen/controller/dashboard_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => StoreController());
    Get.lazyPut(() => RfqController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => ClickTrackingController());
  }
}
