import 'dart:ui';

class StopModel {
  double stop;
  Color color;
  StopModel({required this.stop, required this.color});
  factory StopModel.fromJson(Map<String, dynamic> json) {
    return StopModel(
      stop: json['stop'],
      color: Color(int.parse(json['color'])),
    );
  }

  toJson() {
    return {
      'stop': stop,
      'color': color.value,
    };
  }
}
