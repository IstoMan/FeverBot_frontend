import 'package:manifesto/features/dashboard/presentation/bindings/dashboard_binding.dart';
import 'package:manifesto/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:manifesto/features/onboarding/presentation/bindings/onboarding_binding.dart';
import 'package:manifesto/features/onboarding/presentation/pages/habits_page.dart';
import 'package:manifesto/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:manifesto/features/signup/presentation/bindings/signup_binding.dart';
import 'package:manifesto/features/signup/presentation/pages/signup_page.dart';
import 'package:manifesto/features/login/presentation/bindings/login_binding.dart';
import 'package:manifesto/features/login/presentation/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:manifesto/features/home/presentation/bindings/home_binding.dart';
import 'package:manifesto/features/home/presentation/pages/home_page.dart';
import 'package:manifesto/routes/app_routes.dart';
import 'package:manifesto/app/page_not_found.dart';

class AppPages {
  static const initial = AppRoutes.signup;

  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.pageNotFound,
      page: () => const PageNotFound(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    )
  ];
}
