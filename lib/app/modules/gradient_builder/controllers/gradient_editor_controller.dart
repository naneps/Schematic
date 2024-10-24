import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:schematic/app/commons/theme_manager.dart';
import 'package:schematic/app/enums/gradient.enum.dart';
import 'package:schematic/app/models/builder_models/aligment_geomertry.model.dart';
import 'package:schematic/app/models/builder_models/gradient.model.dart';
import 'package:schematic/app/models/builder_models/stop.model.dart';

class GradientEditorController extends GetxController {
  ScrollController scrollController = ScrollController();
  Rx<GradientModel> gradient = GradientModel(
    type: GradientType.linear,
    colors: [
      ThemeManager().primaryColor,
      ThemeManager().secondaryColor,
    ].obs,
    stops: null,
    begin: AlignmentGeometryModel(x: 0, y: 0, type: AlignmentType.topLeft),
    end: AlignmentGeometryModel(x: 1, y: 1, type: AlignmentType.bottomRight),
    tileMode: TileModeType.clamp,
    center: AlignmentGeometryModel(x: 0, y: 0),
    radius: 0.5,
    startAngle: 0.0,
    endAngle: 3.14,
  ).obs;

  void onAddStops() {
    gradient.update((val) {
      final double increment = 1.0 / (val!.colors.length - 1);
      val.stops = List.generate(val.colors.length, (index) {
        return StopModel(
          color: val.colors[index],
          stop: index * increment,
        );
      });
    });
  }

  void onBeginAlignmentChanged(AlignmentType alignmentType) {
    gradient.value.begin = AlignmentGeometryModel(
      type: alignmentType,
      x: alignmentType.alignment.x,
      y: alignmentType.alignment.y,
    );
    gradient.refresh();
  }

  void onBeginXChanged(value) {
    gradient.update((val) {
      val!.begin!.type = null;
      val.begin = val.begin!.copyWith(x: value, type: null);
    });
  }

  void onBeginYChanged(value) {
    gradient.update((val) {
      val!.begin!.type = null;
      val.begin = val.begin!.copyWith(y: value, type: null);
    });
  }

  void onClearStops() {
    gradient.update((val) {
      val!.stops = null;
    });
    gradient.refresh();
  }

  void onColorsChanged(List<Color> value) {
    gradient.update((val) {
      val!.colors.value = value;
    });
    if (gradient.value.stops != null) {
      onAddStops();
    }
    gradient.refresh();
  }

  void onEndAlignmentChanged(AlignmentType alignmentType) {
    gradient.value.end = AlignmentGeometryModel(
      type: alignmentType,
      x: alignmentType.alignment.x,
      y: alignmentType.alignment.y,
    );
    gradient.refresh();
  }

  void onEndXChanged(value) {
    gradient.update((val) {
      val!.end!.type = null;
      val.end = val.end!.copyWith(x: value, type: null);
    });
    gradient.refresh();
  }

  void onEndYChanged(value) {
    gradient.update((val) {
      val!.end!.type = null;
      val.end = val.end!.copyWith(y: value, type: null);
    });
    gradient.refresh();
  }
}
