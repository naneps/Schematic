import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schematic/app/themes/theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SCHEMATIC STUDIO",
      initialRoute: Routes.CORE,
      getPages: AppPages.routes,
      theme: ThemeApp.defaultTheme,
    ),
  );
}
