import 'package:flutter/material.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/models/gradient.model.dart';

class BoxDecorationModel {
  Color? color;
  List<BoxShadow>? boxShadow;
  GradientModel? gradient;
  BlendMode? backgroundBlendMode;
  BoxDecorationModel({
    this.color,
    this.backgroundBlendMode,
    this.boxShadow,
    this.gradient,
  });

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      color: color,
      backgroundBlendMode: backgroundBlendMode,
      boxShadow: boxShadow,
      gradient: gradient?.toGradient().value,
      border: Border.all(
        color: ThemeManager().blackColor,
        width: 10,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
