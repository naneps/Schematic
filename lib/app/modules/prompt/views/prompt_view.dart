import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/modules/prompt/widgets/form_prompt_field.dart';

import '../controllers/prompt_controller.dart';

class PromptView extends GetView<PromptController> {
  const PromptView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FormPromptField(),
    );
  }
}
