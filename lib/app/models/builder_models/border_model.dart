import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BorderModel {
  Rx<BorderSide> top = BorderSide.none.obs;
  Rx<BorderSide> right = BorderSide.none.obs;
  Rx<BorderSide> bottom = BorderSide.none.obs;
  Rx<BorderSide> left = BorderSide.none.obs;

  BorderModel({
    BorderSide? top,
    BorderSide? right,
    BorderSide? bottom,
    BorderSide? left,
  }) {
    this.top.value = top ?? BorderSide.none;
    this.right.value = right ?? BorderSide.none;
    this.bottom.value = bottom ?? BorderSide.none;
    this.left.value = left ?? BorderSide.none;
  }

  BorderModel.all(BorderSide border) {
    top.value = border;
    right.value = border;
    bottom.value = border;
    left.value = border;
  }

  BorderModel.only({
    BorderSide? top,
    BorderSide? right,
    BorderSide? bottom,
    BorderSide? left,
  }) {
    this.top.value = top ?? BorderSide.none;
    this.right.value = right ?? BorderSide.none;
    this.bottom.value = bottom ?? BorderSide.none;
    this.left.value = left ?? BorderSide.none;
  }

  Border get toBorder => Border(
        top: top.value,
        right: right.value,
        bottom: bottom.value,
        left: left.value,
      );

  void updateAll(BorderSide border) {
    top.value = border;
    right.value = border;
    bottom.value = border;
    left.value = border;
  }

  // Update methods for reactive changes
  void updateBorder({
    BorderSide? top,
    BorderSide? right,
    BorderSide? bottom,
    BorderSide? left,
  }) {
    if (top != null) this.top.value = top;
    if (right != null) this.right.value = right;
    if (bottom != null) this.bottom.value = bottom;
    if (left != null) this.left.value = left;
  }
}
