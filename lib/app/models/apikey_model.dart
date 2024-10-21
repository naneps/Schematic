class ApiKey {
  String id;
  String keyValue;
  String name;
  DateTime createdAt;
  DateTime? lastUsed;
  bool isDefault;
  bool isActive;

  ApiKey({
    required this.id,
    required this.keyValue,
    required this.name,
    required this.createdAt,
    this.lastUsed,
    this.isDefault = false,
    this.isActive = true,
  });
}
