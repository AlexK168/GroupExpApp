class AuthError {
  AuthError({
    required this.emailErrors,
    required this.passErrors,
    required this.nonFieldsErrors
  });

  List<String> nonFieldsErrors;
  List<String> emailErrors;
  List<String> passErrors;

  factory AuthError.fromJson(Map<String, dynamic> json) => AuthError(
    emailErrors: json['email'] == null ? [] : List<String>.from(json['email']),
    nonFieldsErrors: json['non_field_errors'] == null ? [] : List<String>.from(json['non_field_errors']),
    passErrors: json['password'] == null ? [] : List<String>.from(json['password']),
  );

  @override
  String toString() {
    if (emailErrors.isNotEmpty) {
      return "Email: " + emailErrors.join("; ");
    } else
    if (passErrors.isNotEmpty) {
      return "Password: " + passErrors.join("; ");
    } else
    if (nonFieldsErrors.isNotEmpty) {
      return nonFieldsErrors.join("; ");
    }
    return "Error";
  }
}