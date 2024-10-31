import 'package:get/get.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/repositories/gradient_repository.dart';

class GradientPublicController {
  final gradientRepo = Get.find<GradientRepository>();
  Stream<List<UserGradientModel>> getGradients() {
    return gradientRepo.getPublicGradients();
  }

  Future<void> onLikeGradient(String id) async {
    gradientRepo.onLikeGradient(id);
  }
}
