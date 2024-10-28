import 'package:get/get.dart';

class BoxshadowBuilderController extends GetxController {
  var isBottomSheetVisible = false.obs;

  void toggleBottomSheet() {
    isBottomSheetVisible.value = !isBottomSheetVisible.value;
  }
}
