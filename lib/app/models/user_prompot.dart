import 'package:schematic/app/models/promp.model.dart';

class UserPromptModel {
  String? id;
  String? title;
  Prompt? prompt;
  String? userId;

  UserPromptModel({
    this.id,
    this.title,
    this.prompt,
    this.userId,
  });

  factory UserPromptModel.fromJson(Map<String, dynamic> json) {
    // print("prompt ${json['prompt']}");
    return UserPromptModel(
      id: json['id'],
      title: json['title'],
      prompt: Prompt.fromJson(json['prompt']),
      userId: json['userId'],
    );
  }
  factory UserPromptModel.fromMap(String id, Map<String, dynamic> map) {
    return UserPromptModel(
      id: id,
      title: map['title'],
      userId: map['userId'],
      prompt: Prompt.fromJson(Map<String, dynamic>.from(map['prompt'] as Map)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'prompt': prompt?.toJson(),
      'userId': userId,
    };
  }
}
