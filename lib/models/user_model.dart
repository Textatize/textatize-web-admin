class User {
  final String uniqueId;
  final String email;
  bool enabled;

  User({required this.uniqueId, required this.email, required this.enabled});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uniqueId: json["unique_id"],
      email: json["email"],
      enabled: json["enabled"],
    );
  }
}
