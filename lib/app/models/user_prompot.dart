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

  UserPromptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    prompt = json['prompt'] != null ? Prompt.fromJson(json['prompt']) : null;
    userId = json['userId'];
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
