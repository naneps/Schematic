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
}
