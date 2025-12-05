import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:matloob_admin/firebase_options.dart';
import 'package:matloob_admin/utils/app_strings.dart';
import 'package:matloob_admin/utils/app_theme.dart';
import 'package:matloob_admin/utils/route_generator.dart';
import 'package:matloob_admin/utils/screen_bindings.dart';
import 'package:matloob_admin/utils/session_management/session_management.dart';
import 'package:matloob_admin/utils/session_management/session_token_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder<String>(
          future: _getInitialRoute(),
          builder: (context, snapshot) {
            // Show loading screen while determining initial route
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(debugShowCheckedModeBanner: false, home: Scaffold(body: Center(child: CircularProgressIndicator())));
            }

            // Get the initial route from snapshot
            final initialRoute = snapshot.data ?? kAuthScreenRoute;

            return GetMaterialApp(
              theme: buildTheme(Brightness.light),
              title: 'Matloob Admin',
              defaultTransition: Transition.noTransition,
              debugShowCheckedModeBanner: false,
              initialBinding: ScreenBindings(),
              initialRoute: initialRoute,
              getPages: RouteGenerator.getPages(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0))),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }

  /// Determine the initial route based on authentication status
  Future<String> _getInitialRoute() async {
    final SessionManagement appPreferences = SessionManagement();
    String token = await appPreferences.getSessionToken(tokenKey: SessionTokenKeys.kUserTokenKey);

    // If user has a valid token, go to dashboard, otherwise go to auth
    if (token.isNotEmpty) {
      return kDashboardScreenRoute;
    } else {
      return kAuthScreenRoute;
    }
  }
}
