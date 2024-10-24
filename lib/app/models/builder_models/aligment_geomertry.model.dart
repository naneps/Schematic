import 'package:flutter/material.dart';
import 'package:schematic/app/enums/gradient.enum.dart';

class AlignmentGeometryModel {
  double x;
  double y;
  AlignmentType? type;
  AlignmentGeometryModel({
    required this.x,
    required this.y,
    this.type,
  });
  factory AlignmentGeometryModel.fromJson(Map<String, dynamic> json) {
    return AlignmentGeometryModel(
      x: json['x'],
      y: json['y'],
      type: AlignmentType.values
          .firstWhere((element) => element.name == json['type']),
    );
  }

  AlignmentGeometryModel copyWith({
    double? x,
    double? y,
    AlignmentType? type,
  }) {
    return AlignmentGeometryModel(
      x: x ?? this.x,
      y: y ?? this.y,
      type: type ?? this.type,
    );
  }

  AlignmentGeometry toAlignmentGeometry() {
    return type != null ? type!.alignment : Alignment(x, y);
  }

  toJson() => {'x': x, 'y': y, 'type': type!.name};
}
