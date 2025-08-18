
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:matloob_admin/utils/screen_bindings.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/send_otp_screen.dart';
import '../screens/auth/set_new_pass.dart';
import '../screens/auth/verify_otp_screen.dart';
import '../screens/clicks_tracking_screen/clicks_tracking_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/rfqs/rfqs_screen.dart';
import '../screens/store_management/store_management_screen.dart';
import '../screens/user_management/user_management_screen.dart';
import 'app_strings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kAuthScreenRoute, page: () => AuthScreen(), binding: ScreenBindings(),),
      GetPage(name: kSendOtpScreenRoute, page: () => SendOtpScreen(), binding: ScreenBindings(),),
      GetPage(name: kVerifyOtpScreenRoute, page: () => VerifyOtpScreen(), binding: ScreenBindings(),),
      GetPage(name: kSetNewPassScreenRoute, page: () => SetNewPassScreen(), binding: ScreenBindings(),),
      GetPage(name: kDashboardScreenRoute, page: () => DashboardScreen(), binding: ScreenBindings(),),
      GetPage(name: kStoreManagementScreenRoute, page: () => StoreManagementScreen(), binding: ScreenBindings(),),
      GetPage(name: kRfqScreenRoute, page: () => RfqScreen(), binding: ScreenBindings(),),
      GetPage(name: kUserManagementScreenRoute, page: () => UserManagementScreen(), binding: ScreenBindings(),),
      GetPage(name: kClickTrackingScreenRoute, page: () => ClickTrackingScreen(), binding: ScreenBindings(),),
    ];
  }
}

