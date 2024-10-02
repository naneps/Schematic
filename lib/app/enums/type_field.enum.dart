enum FieldType {
  string,
  number,
  boolean,
  object,
  array,
//   date,
//   dateTime,
//   time,
//   url,
}

extension FieldTypeExtension on FieldType {
  String slug() {
    switch (this) {
      case FieldType.string:
        return 'string';
      case FieldType.number:
        return 'number';
      case FieldType.object:
        return 'object';
      case FieldType.array:
        return 'array';
      case FieldType.boolean:
        return 'boolean';
      default:
        return 'string';
    }
  }

  static FieldType fromString(String type) {
    switch (type) {
      case 'string':
        return FieldType.string;
      case 'number':
        return FieldType.number;
      case 'object':
        return FieldType.object;
      case 'array':
        return FieldType.array;
      case 'boolean':
        return FieldType.boolean;
      default:
        return FieldType.string;
    }
  }
}
