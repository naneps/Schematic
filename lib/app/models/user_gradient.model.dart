import 'package:schematic/app/models/builder_models/gradient.model.dart';

class UserGradientModel {
  final String? id;
  String? uid;
  String? name;
  GradientModel? gradient;
  UserGradientModel({
    this.id,
    this.uid,
    this.gradient,
    this.name,
  });

  factory UserGradientModel.fromJson(String id, Map<String, dynamic> json) {
    return UserGradientModel(
      id: id,
      uid: json['uid'],
      gradient: GradientModel.fromJson(Map.from(json['gradient'])),
      name: json['name'],
    );
  }

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
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': DateTime.now().millisecondsSinceEpoch
    };
  }
}
