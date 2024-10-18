import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/boxshadow_builder/bindings/boxshadow_builder_binding.dart';
import '../modules/boxshadow_builder/views/boxshadow_builder_view.dart';
import '../modules/container_builder/bindings/container_builder_binding.dart';
import '../modules/container_builder/views/container_builder_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/gradient_builder/bindings/gradient_builder_binding.dart';
import '../modules/gradient_builder/views/gradient_builder_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/prompt/bindings/prompt_binding.dart';
import '../modules/prompt/views/prompt_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/tools/bindings/tools_binding.dart';
import '../modules/tools/views/tools_view.dart';
import '../services/auth_middlerware.dart';

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
      bindings: [
        PromptBinding(),
        ToolsBinding(),
        SettingBinding(),
        ContainerBuilderBinding(),
      ],
    ),
    GetPage(
      name: _Paths.PROMPT,
      page: () => const PromptView(),
      binding: PromptBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.TOOLS,
      page: () => const ToolsView(),
      binding: ToolsBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
        name: _Paths.GRADIENT_BUILDER,
        page: () => const GradientBuilderView(),
        binding: GradientBuilderBinding(),
        bindings: [ContainerBuilderBinding()]),
    GetPage(
      name: _Paths.BOXSHADOW_BUILDER,
      page: () => const BoxshadowBuilderView(),
      binding: BoxshadowBuilderBinding(),
    ),
    GetPage(
      name: _Paths.CONTAINER_BUILDER,
      page: () => const ContainerBuilderView(),
      binding: ContainerBuilderBinding(),
    ),
  ];

  AppPages._();
}
