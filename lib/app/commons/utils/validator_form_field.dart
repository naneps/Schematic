/// A utility class for validating form fields based on different validators.
/// [ValidatorFormField] provides a static method [validate] that can be used to validate form fields based on different validators.
class ValidatorFormField {
  /// Validates the given [value] based on the specified [validator] and returns an error message if validation fails.
  ///
  /// The [value] parameter represents the input value to be validated.
  ///
  /// The [validator] parameter is a string that contains one or more validators separated by '|'. Each validator can have additional parameters separated by ':'.
  ///
  /// The [customErrorMessages] parameter is an optional map that allows you to provide custom error messages for each validator. If a custom error message is not provided for a validator, a default error message is used.
  ///
  /// Returns `null` if the validation succeeds, otherwise returns an error message indicating the reason for validation failure.
  static String? validate({
    required String value,
    required String validator,
    Map<String, String>? customErrorMessages,
  }) {
    /// Split the validator string into individual validators and iterate through each one to validate the value.
    final validators = validator.split('|');
    for (final validator in validators) {
      final parts = validator.split(':');
      final validatorType = parts[0];
      switch (validatorType) {
        case 'required':
          if (value.isEmpty) {
            return customErrorMessages?['required'] ?? 'Field is required';
          }
          break;
        case 'email':
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return customErrorMessages?['email'] ??
                'Please enter a valid email';
          }
          break;
        case 'password':
          final passwordRegex =
              RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
          if (!passwordRegex.hasMatch(value)) {
            return customErrorMessages?['password'] ??
                'Password must contain at least 8 characters, including uppercase, lowercase, and number';
          }
          break;
        case 'min':
          final minSize = int.tryParse(parts[1] ?? '');
          if (minSize != null && (value.length < minSize)) {
            return customErrorMessages?['min'] ??
                'Minimum length is $minSize characters';
          }
          break;
        case 'max':
          final maxSize = int.tryParse(parts[1] ?? '');
          if (maxSize != null && (value.length > maxSize)) {
            return customErrorMessages?['max'] ??
                'Maximum length is $maxSize characters';
          }
          break;
        case 'time':
          final timeRegex = RegExp(
              r'^([01]?[0-9]|2[0-3]|[0]?[0-9]):[0-5][0-9] ?(?:AM|PM|am|pm)?$');

          if (!timeRegex.hasMatch(value)) {
            return customErrorMessages?['time'] ?? 'Please enter a valid time';
          }
          break;
        case 'date':
          final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
          if (!dateRegex.hasMatch(value)) {
            return customErrorMessages?['date'] ?? 'Please enter a valid date';
          }
          break;
        // Add more cases for other validators as needed
        default:
          break;
      }
    }
    return null;
  }
}
