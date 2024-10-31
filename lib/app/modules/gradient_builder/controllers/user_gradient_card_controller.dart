import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/user.model.dart';
import 'package:schematic/app/models/user_gradient.model.dart';
import 'package:schematic/app/repositories/gradient_repository.dart';
import 'package:schematic/app/services/user_service.dart';

class UserGradientCardController extends GetxController {
  final gradientRepo = Get.find<GradientRepository>();
  final userService = Get.find<UserService>();
  UserGradientModel? userGradient;
  RxBool isLoading = true.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);
  UserGradientCardController({this.userGradient});

  Future<UserModel> fetchUser(String userId) async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userGradient!.userId)
        .get();
    return UserModel.fromFirestore(docSnapshot.data()!, docSnapshot.id);
  }

  void getUser() async {
    user.value = await fetchUser(userService.uid);
    isLoading.value = false;
  }

  void likeGradient() async {
    await gradientRepo.onLikeGradient(userGradient!.id!);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void saveGradient() async {
    await gradientRepo.saveGradient(userGradient!.id!);
    update();
  }
}
