import 'dart:ui';

class StopModel {
  double stop;
  Color color;
  StopModel({required this.stop, required this.color});
  factory StopModel.fromJson(Map<String, dynamic> json) {
    print("stop json: $json");
    return StopModel(
      stop: double.parse(json['stop'].toString()),
      color: Color(json['color']),
    );
  }

  toJson() {
    return {
      'stop': stop,
      'color': color.value,
    };
  }
}
