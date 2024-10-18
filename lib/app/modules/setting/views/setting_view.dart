import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(),
    );
  }
}
