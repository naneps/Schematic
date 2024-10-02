enum RemoteConfigKey {
  welcomeMessage,
  featureEnabled,
  enableAnon,
  copyWriteFormLogin
}

extension RemoteConfigKeyExtension on RemoteConfigKey {
  String get key => toString().split('.').last;
}
