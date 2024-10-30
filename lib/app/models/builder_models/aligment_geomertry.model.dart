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
      x: json['x'] != null ? double.parse(json['x'].toString()) : 0.0,
      y: json['y'] != null ? double.parse(json['y'].toString()) : 0.0,
      type: json['type'] != null
          ? AlignmentType.values
              .firstWhere((element) => element.name == json['type'])
          : null,
    );
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ type.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AlignmentGeometryModel &&
        other.x == x &&
        other.y == y &&
        other.type == type;
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

  toJson() => {'x': x, 'y': y, 'type': type?.name};

  @override
  String toString() {
    return 'AlignmentGeometryModel(x: $x, y: $y, type: $type)';
  }
}
