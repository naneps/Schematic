import 'dart:core';

import 'package:get/get.dart';
import 'package:schematic/app/models/field.model.dart';

class Prompt {
  String? text;
  RxList<Field>? fields;
  RxInt? maxData;

  Prompt({this.text, this.fields, this.maxData});

  factory Prompt.fromJson(Map<String, dynamic> json) {
    return Prompt(
      text: json['text'],
      // fields: json['fields']?.map<Field>((f) => Field.fromJson(f)).toList(),
      maxData: json['maxData'],
    );
  }

  bool get allFieldKeyUnique {
    final keys = fields?.map((f) => f.key?.value).toList() ?? [];
    return keys.toSet().length == keys.length;
  }

  String get fieldsToMarkdown =>
      fields?.map((f) => f.toMarkdown()).join() ?? '';

  void removeField(String id) {
    fields?.removeWhere((element) => element.id == id);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fields': fields?.map((f) => f.toJson()).toList(),
      'maxData': maxData
    };
  }

  String toMarkdown() {
    final fieldsMarkdown =
        fields?.map((f) => f.toMarkdown(indentLevel: 1)).join(',\n') ?? '';
    return '''
```json
{
$fieldsMarkdown
}
''';
  }

  String toPrompt() {
    final fieldsPrompt = fields?.map((f) => f.toPrompt()).join(', ') ?? '';
    return ' ${text ?? ''},with fields { $fieldsPrompt }';
  }
}
