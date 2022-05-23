class User {
  final int id;
  final String username;
  final String password;
  final String email;

  const User({this.id = 0, this.username = "dummy", this.email = "dummy@dummy.dummy", this.password = ""});

  // factory AuthError.fromJson(Map<String, dynamic> json) => AuthError(
  //   emailErrors: json['email'] == null ? [] : List<String>.from(json['email']),
  //   nonFieldsErrors: json['non_field_errors'] == null ? [] : List<String>.from(json['non_field_errors']),
  //   passErrors: json['password'] == null ? [] : List<String>.from(json['password']),
  //   usernameErrors: json['username'] == null ? [] : List<String>.from(json['username']),
  //   detail: json['detail'] ?? "",
  // );
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    username: json['username'] ?? "None",
    email: json['email'] ?? "None",
    password: json['password'] ?? "None",
  );


  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'password': password
  };

  String toString() {
    return "id: $id\nusername: $username\nemail: $email\npassword: $password";
  }
}

User mockUser = const User(email: "babba_gump@gmail.com", password: "nsvZwA+\$UcP8m.");