class Field {
  String? key;
  FieldType? type;
  String? description;
  List<Field>? subFields;
  FieldType? subType; // You need to add this

  Field({this.key, this.type, this.subFields, this.subType});

  get arrayElementType => null;

  bool get isArrayOfObjects =>
      type == FieldType.array && subType == FieldType.object;

  // Convert the field to a prompt representation
  String toPrompt() {
    if (type == FieldType.object) {
      return '$key: { ${subFields?.map((f) => f.toPrompt()).join(', ')} }';
    } else if (type == FieldType.array) {
      return '$key: [ ${subFields?.map((f) => f.toPrompt()).join(', ')} ]';
    } else {
      return '$key: ${type.toString().split('.').last}';
    }
  }
}

enum FieldType {
  string,
  number,
  object,
  array,
}

class Prompt {
  String? text;
  List<Field>? fields;

  Prompt({this.text, this.fields});

  // Convert the prompt and fields to a prompt representation
  String toPrompt() {
    final fieldDescriptions = fields?.map((f) => f.toPrompt()).join(', ') ?? '';
    return '$text { $fieldDescriptions }';
  }
}

extension FieldTypeExtension on FieldType {
  String get name => toString().split('.').last.toUpperCase();
  String get value => toString().split('.').last;
}
