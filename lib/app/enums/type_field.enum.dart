enum FieldType {
  string,
  number,
  object,
  array,
}

extension FieldTypeExtension on FieldType {
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
      default:
        return FieldType.string;
    }
  }
}
