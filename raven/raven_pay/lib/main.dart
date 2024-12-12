import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'core/utils/app_logger.dart';
import 'core/values/strings/text_constants.dart';
import 'core/values/styles/app_theme.dart';
import 'routes/routes.dart';
import 'shared/shared_binding.dart';

class Main {}

Future<void> main() async {
  final logger = appLogger(Main);
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await initialize();
      runApp(const RavenPay());
    },
    (error, stackTrace) => logger.e(
      error.toString(),
      stackTrace: stackTrace,
      functionName: MAIN,
    ),
  );
}

class RavenPay extends StatelessWidget {
  const RavenPay({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => GetMaterialApp(
        scrollBehavior: SBehavior(),
        theme: AppThemeData.lightTheme,
        darkTheme: AppThemeData.darkTheme,
        themeMode: ThemeMode.system,
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialBinding: GlobalBinding(),
        initialRoute: Routes.home,
        getPages: Routes.routes,
      ),
    );
  }
}
