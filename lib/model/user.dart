class User {
  final int id;
  final String username;
  final String password;
  final String email;

  const User({this.id = 0, this.username = "dummy", this.email = "dummy@dummy.dummy", this.password = ""});


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

  @override
  bool operator ==(Object other) {
    return other is User &&
        id == other.id &&
        username == other.username &&
        email == other.email;
  }
}

class UsersList {
  final List<User> users;

  UsersList({
    required this.users,
  });

  factory UsersList.fromJson(List<dynamic> parsedJson) {
    List<User> users = parsedJson.map((i)=>User.fromJson(i)).toList();
    return UsersList(users: users);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> usersList = [];
    for (User user in users) {
      var userMap = user.toJson();
      usersList.add(userMap);
    }
    return usersList;
  }
}