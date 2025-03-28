// user model with id, name, email, and password

class User {
  int? id;
  String? name;
  String? email;
  String? password;

  User({this.id, this.name, this.email, this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
      };
}