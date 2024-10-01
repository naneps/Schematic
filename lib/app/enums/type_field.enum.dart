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
