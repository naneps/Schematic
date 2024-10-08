import 'dart:math';

import 'package:get/get.dart';
import 'package:schematic/app/enums/type_field.enum.dart';

class Field {
  String id; // Changed to String
  RxString? key;
  Rx<FieldType>? type;
  RxString? description;
  RxList<Field>? subFields;
  Rx<FieldType>? subType;
  RxInt? count;

  Field({
    this.key,
    this.type,
    this.subFields,
    this.subType,
    this.description,
    this.count,
  }) : id = _generateUniqueId();
  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      key: RxString(
          json['key'] ?? ''), // Fallback to empty string if 'key' is null
      type: FieldTypeExtension.fromString(json['type'] ?? 'string').obs,
      description: RxString(json['description'] ??
          ''), // Fallback to empty string if 'description' is null
      subFields: json['subFields'] != null && json['subFields'] is List
          ? RxList<Field>.from(json['subFields']
              .map((x) => Field.fromJson(x))) // Safely map over subFields
          : RxList<Field>([]), // Use an emp    ty list if 'subFields' is null
      subType: FieldTypeExtension.fromString(json['subtype'] ?? 'string').obs,
      count: RxInt(json['count'] ?? 4), // Default count value
    );
  }

  bool get allSubFieldKeyUnique =>
      subFields?.map((f) => f.key?.value).toSet().length == subFields?.length;
  bool get isArrayOfObjects =>
      type!.value == FieldType.array && subType!.value == FieldType.object;
  Field copyWith({
    RxString? key,
    Rx<FieldType>? type,
    RxString? description,
    RxList<Field>? subFields,
    Rx<FieldType>? subType,
  }) {
    return Field(
      key: key ?? this.key,
      type: type ?? this.type,
      description: description ?? this.description,
      subFields: subFields ?? this.subFields,
      subType: subType ?? this.subType,
    );
  }

  toJson() => {
        'key': key?.value,
        'type': type?.value.slug(),
        'description': description?.value,
        'subFields': subFields?.map((f) => f.toJson()).toList(),
        'subtype': subType?.value.slug(),
        if (type?.value == FieldType.array) 'count': count?.value
      };

  String toMarkdown({int indentLevel = 0}) {
    final indent =
        '  ' * indentLevel; // Menghasilkan indentasi berdasarkan level

    if (type?.value == FieldType.object) {
      final fieldsMarkdown = subFields
              ?.map((f) => f.toMarkdown(indentLevel: indentLevel + 1))
              .join(',\n') ??
          '';
      return '$indent"${key?.value}": {\n'
          '$fieldsMarkdown\n'
          '$indent}';
    } else if (type?.value == FieldType.array) {
      final fieldsMarkdown = subFields
              ?.map((f) => f.toMarkdown(indentLevel: indentLevel + 1))
              .join(',\n') ??
          '';
      return '$indent"${key?.value}": [\n'
          '$fieldsMarkdown\n'
          '$indent]';
    } else {
      return '$indent"${key?.value}": "${type?.value.toString().split('.').last}"';
    }
  }

  String toPrompt() {
    if (type?.value == FieldType.object) {
      return '${key?.value}: { ${subFields?.map((f) => f.toPrompt()).join(', ')} } | Description: ${description?.value} ';
    } else if (type?.value == FieldType.array) {
      return '${key?.value}: [ ${subFields?.map((f) => f.toPrompt()).join(', ')} ] | Array Of: ${subType?.value.toString().split('.').last} | Description: ${description?.value} | Count: ${count?.value}';
    } else {
      return '${key?.value}: ${type?.value.toString().split('.').last} | Description: ${description?.value}';
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return "key: ${key?.value}, type: ${type?.value}, description: ${description?.value}, subFields: ${subFields?.length}, subType: ${subType?.value}, count: ${count?.value}";
  }

  static Field defaultValue() => Field(
        key: ''.obs,
        type: FieldType.string.obs,
        subType: FieldType.string.obs,
        subFields: RxList<Field>([]),
        description: ''.obs,
      );
  static String _generateUniqueId() {
    const length = 10;
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random random = Random();
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final int index = random.nextInt(chars.length);
      buffer.write(chars[index]);
    }
    return buffer.toString();
  }
}
