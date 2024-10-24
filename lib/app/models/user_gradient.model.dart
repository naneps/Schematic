import 'package:schematic/app/models/builder_models/gradient.model.dart';

class UserGradientModel {
  final String? uid;
  final String? name;
  final GradientModel? gradient;
  UserGradientModel({
    this.uid,
    this.gradient,
    this.name,
  });

  factory UserGradientModel.fromJson(Map<String, dynamic> json) {
    return UserGradientModel(
      uid: json['uid'],
      gradient: GradientModel.fromJson(json['gradient']),
      name: json['name'],
    );
  }

  toJson() {
    return {
      'uid': uid,
      'gradient': gradient?.toJson(),
      'name': name,
      'colors': gradient?.colors.map((color) => color.value).toList(),
      'gradient_code': gradient?.toCode(),
      'gradient_type': gradient?.type.name
    };
  }
}
