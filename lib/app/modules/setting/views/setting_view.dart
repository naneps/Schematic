import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/responsive_layout.dart';
import 'package:schematic/app/modules/setting/views/api_key_list_view.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: buildContent(),
        ),
        tablet: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: buildContent(),
          ),
        ),
      ),
    );
  }

  Widget buildContent() {
    return const ApikeyListView();
  }
}
