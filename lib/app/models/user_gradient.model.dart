import 'package:schematic/app/models/builder_models/gradient.model.dart';

class UserGradientModel {
  final String? id;
  String? uid;
  String? name;
  GradientModel? gradient;
  bool? published = false;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  UserGradientModel({
    this.id,
    this.uid,
    this.gradient,
    this.name,
    this.published,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserGradientModel.fromJson(String id, Map<String, dynamic> json) {
    return UserGradientModel(
      id: id,
      uid: json['uid'],
      gradient: GradientModel.fromJson(Map.from(json['gradient'])),
      name: json['name'],
      published: json['published'] ?? false,
    );
  }

  @override
  int get hashCode {
    return name.hashCode ^ gradient.hashCode;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGradientModel &&
          runtimeType == other.runtimeType &&
          id == other.id;
  UserGradientModel copyWith({
    String? id,
    String? uid,
    String? name,
    GradientModel? gradient,
  }) {
    return UserGradientModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      gradient: gradient ?? this.gradient,
    );
  }

  toJson() {
    return {
      'uid': uid,
      'gradient': gradient?.toJson(),
      'name': name ?? 'New Gradient',
      'colors': gradient!.colors.map((color) => color.value).toList(),
      'gradient_code': gradient?.toCode(),
      'gradient_type': gradient?.type.name,
      'published': published,
      'created_at': createdAt ?? DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch
    };
  }

  //   hascode

  @override
  String toString() {
    return 'UserGradientModel{id: $id, uid: $uid, name: $name, gradient: $gradient, published: $published, publishedAt: $publishedAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
