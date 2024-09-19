import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/routes/app_pages.dart';
import 'package:schematic/app/services/app_translation.dart';

class MainApp extends StatelessWidget {
  final AppTranslations translations;
  const MainApp({super.key, required this.translations});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: translations,
      translationsKeys: translations.keys,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeManager().themeData,
      initialRoute: AppPages.INITIAL,
    );
  }
}
