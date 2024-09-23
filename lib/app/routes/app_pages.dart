import 'package:get/get.dart';
import 'package:schematic/app/services/auth_middlerware.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/prompt/bindings/prompt_binding.dart';
import '../modules/prompt/views/prompt_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.CORE,
      page: () => const CoreView(),
      binding: CoreBinding(),
      middlewares: [AuthMiddleware()],
      bindings: [PromptBinding()],
    ),
    GetPage(
      name: _Paths.PROMPT,
      page: () => const PromptView(),
      binding: PromptBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];

  AppPages._();
}
