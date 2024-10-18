import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/boxshadow_builder_controller.dart';

class BoxshadowBuilderView extends GetView<BoxshadowBuilderController> {
  const BoxshadowBuilderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BoxshadowBuilderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BoxshadowBuilderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
