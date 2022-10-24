class HttpResponseError {
  HttpResponseError({
    this.emailErrors = const[],
    this.passErrors = const[],
    this.nonFieldsErrors = const[],
    this.usernameErrors = const[],
    this.detail = "",
  });

  List<String> nonFieldsErrors;
  List<String> usernameErrors;
  List<String> emailErrors;
  List<String> passErrors;
  String detail;

  factory HttpResponseError.fromJson(Map<String, dynamic> json) => HttpResponseError(
    emailErrors: json['email'] == null ? [] : List<String>.from(json['email']),
    nonFieldsErrors: json['non_field_errors'] == null ? [] : List<String>.from(json['non_field_errors']),
    passErrors: json['password'] == null ? [] : List<String>.from(json['password']),
    usernameErrors: json['username'] == null ? [] : List<String>.from(json['username']),
    detail: json['detail'] ?? "",
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
    if (usernameErrors.isNotEmpty) {
      return "Username: " + usernameErrors.join("; ");
    }
    if (detail.isNotEmpty) {
      return detail;
    }
    return "Error";
  }
}