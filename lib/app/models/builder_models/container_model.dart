import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/builder_models/box_decoration_model.dart';

class ContainerModel {
  RxDouble? width;
  RxDouble? height;
  Color? color;
  BoxDecorationModel? decoration;
  ContainerModel({
    this.width,
    this.height,
    this.color,
    this.decoration,
  });

  ContainerModel copyWith({
    double? width,
    double? height,
    Color? color,
    BoxDecorationModel? decoration,
  }) {
    return ContainerModel(
      width: RxDouble(width ?? this.width!.value),
      height: RxDouble(height ?? this.height!.value),
      decoration: decoration ?? this.decoration,
      color: color ?? this.color,
    );
  }

  String toCode() {
    return '```dart\n${widget().toString()}\n```';
  }

  Widget widget() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width!.value,
      height: height!.value,
      color: color,
      decoration: decoration?.toBoxDecoration(),
    );
  }
}
