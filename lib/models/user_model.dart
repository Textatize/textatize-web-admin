class User {
  final String uniqueId;
  final String email;

  User({required this.uniqueId, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(uniqueId: json["unique_id"], email: json["email"]);
  }
}
