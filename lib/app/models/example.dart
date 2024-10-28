class ModelA {
  int? id;
  String? name;
  ModelB? modelB;

  ModelA({this.id, this.name, this.modelB});
  factory ModelA.fromJson(Map<String, dynamic> json) => ModelA(
        id: json['id'],
        name: json['name'],
        modelB: json['modelB'] != null ? ModelB.fromJson(json['modelB']) : null,
      );
}

class ModelB {
  int? id;
  String? name;

  ModelB({this.id, this.name});
  factory ModelB.fromJson(Map<String, dynamic> json) => ModelB(
        id: json['id'],
        name: json['name'],
      );
}
