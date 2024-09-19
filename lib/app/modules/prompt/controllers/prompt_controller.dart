import 'package:get/get.dart';
import 'package:schematic/app/services/google_generative_service.dart';

class PromptController extends GetxController {
  final generativeService = Get.find<GoogleGenerativeService>();
}
