import 'package:get/get.dart';
import 'package:schematic/app/models/apikey_model.dart';

class SettingController extends GetxController {
  // List of complex API keys
  RxList<ApiKey> apiKeys = <ApiKey>[
    ApiKey(
      id: "1",
      keyValue: "GEMINI-12345-ABCDE",
      name: "Primary API Key",
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastUsed: DateTime.now().subtract(const Duration(days: 2)),
      isDefault: true,
      isActive: true,
    ),
    ApiKey(
      id: "2",
      keyValue: "GEMINI-67890-FGHIJ",
      name: "Backup Key",
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      lastUsed: DateTime.now().subtract(const Duration(days: 15)),
      isDefault: false,
      isActive: true,
    ),
    ApiKey(
      id: "3",
      keyValue: "GEMINI-54321-XYZWV",
      name: "Old Key",
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      lastUsed: DateTime.now().subtract(const Duration(days: 60)),
      isDefault: false,
      isActive: false,
    ),
  ].obs;

  // Method to set the default API key
  void setDefaultApiKey(int index) {
    for (var i = 0; i < apiKeys.length; i++) {
      apiKeys[i] = apiKeys[i].copyWith(isDefault: i == index);
    }
    apiKeys.refresh(); // Update the reactive list
  }

  // Method to activate or deactivate an API key
  void toggleApiKeyStatus(int index) {
    apiKeys[index] =
        apiKeys[index].copyWith(isActive: !apiKeys[index].isActive);
    apiKeys.refresh();
  }

  // Method to update the last used timestamp
  void updateLastUsed(int index) {
    apiKeys[index] = apiKeys[index].copyWith(lastUsed: DateTime.now());
    apiKeys.refresh();
  }
}

// Extension to make the ApiKey model mutable
extension ApiKeyCopyWith on ApiKey {
  ApiKey copyWith({
    String? id,
    String? keyValue,
    String? name,
    DateTime? createdAt,
    DateTime? lastUsed,
    bool? isDefault,
    bool? isActive,
  }) {
    return ApiKey(
      id: id ?? this.id,
      keyValue: keyValue ?? this.keyValue,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
    );
  }
}
