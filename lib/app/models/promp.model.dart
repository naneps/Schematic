import 'dart:core';

import 'package:get/get.dart';
import 'package:schematic/app/models/field.model.dart';

class Prompt {
  String? text;
  RxList<Field>? fields;
  RxInt? maxData;

  Prompt({
    this.text,
    this.fields,
  });

  // Check if all field keys are unique
  bool get allFieldKeyUnique =>
      fields?.map((f) => f.key?.value).toSet().length == fields?.length;

  // Convert fields to Markdown
  String get fieldsToMarkdown =>
      fields?.map((f) => f.toMarkdown()).join() ?? '';

  // Remove a field by its ID
  void removeField(String id) {
    fields?.removeWhere((element) => element.id == id);
  }

  // Convert the prompt to Markdown format
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

  // Convert fields to prompt format
  String toPrompt() {
    final fieldsPrompt = fields?.map((f) => f.toPrompt()).join(', ') ?? '';
    return ' ${text ?? ''},with fields { $fieldsPrompt }';
  }
}
