import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/boxshadow_builder_controller.dart';

class BoxshadowBuilderView extends GetView<BoxshadowBuilderController> {
  const BoxshadowBuilderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Bottom Sheet with Stack'),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Tekan tombol mengambang di sudut kiri atas'),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: controller.toggleBottomSheet,
                child: const Icon(Icons.menu),
              ),
            ),
          ),
          Obx(() {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 0,
              left: controller.isBottomSheetVisible.value ? 0 : -400,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.grey.shade200,
                width: 400,
                height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Menu',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
