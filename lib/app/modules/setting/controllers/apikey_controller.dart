import 'package:get/get.dart';
import 'package:schematic/app/commons/ui/overlays/x_snackbar.dart';
import 'package:schematic/app/models/apikey_model.dart';
import 'package:schematic/app/repositories/apikey_repository.dart';

class ApiKeyController extends GetxController with StateMixin<List<ApiKey>> {
  Rx<ApiKey> apiKey = ApiKey(
    id: '',
    keyValue: '',
    name: '',
    isDefault: true.obs,
    userId: '',
  ).obs;
  RxList<ApiKey> apiKeys = <ApiKey>[].obs;
  final apikeyRepository = Get.find<ApikeyRepository>();

  void deleteApi(String id) async {
    try {
      await apikeyRepository.delete(id);
      readAll();
      XSnackBar.show(
        context: Get.context!,
        message: 'Data successfully deleted',
        type: SnackBarType.success,
      );
    } catch (e) {
      XSnackBar.show(
        context: Get.context!,
        message: 'Failed to delete data',
        type: SnackBarType.error,
      );
    }
  }

  @override
  void onInit() {
    readAll();
    super.onInit();
  }

  void readAll() async {
    try {
      apiKeys.value = await apikeyRepository.readAll();
      if (apiKeys.isEmpty) {
        change(apiKeys, status: RxStatus.empty());
      } else {
        change(apiKeys, status: RxStatus.success());
      }
    } catch (e) {
      print(e);
      change(apiKeys, status: RxStatus.error(e.toString()));
    }
  }

  void storeApi() async {
    try {
      await apikeyRepository.create(apiKey.value);
      readAll();
      XSnackBar.show(
        context: Get.context!,
        message: 'Data successfully created',
        type: SnackBarType.success,
      );
    } catch (e) {
      XSnackBar.show(
        context: Get.context!,
        message: 'Failed to create data',
        type: SnackBarType.error,
      );
    }
  }

  void updateApi(ApiKey apiKey) async {
    try {
      await apikeyRepository.update(apiKey.id!, apiKey.toCreateJson());
      readAll();
    } catch (e) {
      XSnackBar.show(
        context: Get.context!,
        message: 'Failed to update data',
        type: SnackBarType.error,
      );
    }
  }
}
