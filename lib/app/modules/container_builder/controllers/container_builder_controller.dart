import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schematic/app/models/box_decoration_model.dart';
import 'package:schematic/app/models/container_model.dart';

class ContainerBuilderController extends GetxController {
  Rx<ContainerModel> container = ContainerModel(
    width: RxDouble(200),
    height: RxDouble(200),
    decoration: BoxDecorationModel(
      color: Colors.red,
    ),
  ).obs;
}
