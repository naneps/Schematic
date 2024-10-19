import 'package:flutter/material.dart';
import 'package:schematic/app/models/border_model.dart';
import 'package:schematic/app/models/gradient.model.dart';

class BoxDecorationModel {
  Color? color;
  List<BoxShadow>? boxShadow;
  GradientModel? gradient;
  BlendMode? backgroundBlendMode;
  BorderModel? border;
  BoxDecorationModel({
    this.color,
    this.backgroundBlendMode,
    this.boxShadow,
    this.gradient,
    this.border,
  });

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      color: color,
      backgroundBlendMode: backgroundBlendMode,
      boxShadow: boxShadow,
      gradient: gradient?.toGradient().value,
      borderRadius: BorderRadius.circular(20),
      border: border?.toBorder,
    );
  }
}
