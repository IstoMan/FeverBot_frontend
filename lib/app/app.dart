import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifesto/common/core/theme/theme.dart';
import 'package:manifesto/app/app_binding.dart';
import 'package:manifesto/routes/app_pages.dart';
import 'package:manifesto/common/core/utils/navigator_observer/app_navigator_observer.dart';
import 'package:manifesto/app/page_not_found.dart';
import 'package:manifesto/common/resources/app_resources/app_sizes.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manifesto/routes/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        designSize: AppSizes.designSize,
        useInheritedMediaQuery: true,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'FeverBot',
            initialBinding: AppBinding(),
            initialRoute: AppPages.initial,
            getPages: AppPages.pages,
            unknownRoute: GetPage(
              name: AppRoutes.pageNotFound,
              page: () => const PageNotFound(),
            ),
            navigatorObservers: [AppNavigatorObserver()],
            useInheritedMediaQuery: true,
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
