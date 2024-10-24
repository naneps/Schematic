import 'package:get/get.dart';

class ApiKey {
  String? id;
  String? keyValue;
  String? name;
  String? userId;
  RxBool? isDefault;

  ApiKey({
    this.id,
    this.keyValue,
    this.name,
    this.isDefault,
    this.userId,
  });

  factory ApiKey.fromJson(String id, Map<String, dynamic> json) => ApiKey(
        id: id,
        keyValue: json['keyValue'],
        name: json['name'],
        isDefault: RxBool(json['isDefault'] ?? false),
        userId: json['userId'],
      );

  ApiKey copyWith({
    String? id,
    String? keyValue,
    String? name,
    bool? isDefault,
    String? userId,
  }) =>
      ApiKey(
        id: id ?? this.id,
        keyValue: keyValue ?? this.keyValue,
        name: name ?? this.name,
        isDefault: RxBool(isDefault ?? this.isDefault!.value),
        userId: userId ?? this.userId,
      );

  Map<String, dynamic> toCreateJson() => {
        'keyValue': keyValue,
        'name': name,
        'isDefault': isDefault!.value,
        'userId': userId,
      };
  @override
  String toString() {
    return 'ApiKey{id: $id, keyValue: $keyValue, name: $name, isDefault: $isDefault, userId: $userId}';
  }
}
