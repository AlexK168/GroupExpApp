class User {
  final int id;
  final String username;
  final String password;
  final String email;

  const User({this.id = 0, this.username = "dummy", this.email = "dummy@dummy.dummy", this.password = ""});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        password = json['password'];

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