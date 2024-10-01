import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:schematic/app/services/firebase/remote_config_keys.dart';

class FirebaseRemoteConfigService extends GetxService {
  // Singleton pattern for FirebaseRemoteConfigService with GetX.
  static FirebaseRemoteConfigService get to =>
      Get.find<FirebaseRemoteConfigService>();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  // Getter to check if a feature is enabled.
  bool get featureEnabled => _remoteConfig.getBool(
        RemoteConfigKey.featureEnabled.key,
      );

  // Getter to retrieve the welcome message from Remote Config.
  String get welcomeMessage => _remoteConfig.getString(
        RemoteConfigKey.welcomeMessage.key,
      );
  // Fetches and activates the latest config from Firebase Remote Config.
  Future<void> fetchLatestConfig() async {
    try {
      print('Fetching remote config');
      await _remoteConfig.fetchAndActivate();
      print('Remote config fetched & activated');
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  String getString(String key) {
    print("Getting string: $key");
    _remoteConfig.fetch();
    print(_remoteConfig.getString(key));
    return _remoteConfig.getString(key);
  }

  // Dynamic method to fetch any key's value.

  // Initialization function, equivalent to the previous init method.
  Future<FirebaseRemoteConfigService> init() async {
    await fetchLatestConfig();
    return this;
  }
}
