class User {
  final String uniqueId;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String phone;
  final int points;
  final String created;
  final String entityStatus;
  final String createdTime;
  final String updatedTime;
  final String createdFormatted;
  bool enabled;

  User({
    required this.uniqueId,
    required this.email,
    required this.enabled,
    required this.phone,
    required this.created,
    required this.firstName,
    required this.lastName,
    required this.entityStatus,
    required this.createdFormatted,
    required this.createdTime,
    required this.updatedTime,
    required this.username,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uniqueId: json["unique_id"],
      email: json["email"],
      enabled: json["entityStatus"] == "active",
      phone: json["phone"],
      created: json["created"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      entityStatus: json["entityStatus"],
      createdFormatted: json["created_formatted"],
      createdTime: json["created_time"],
      updatedTime: json["updated_time"],
      username: json["username"],
      points: json["points"],
    );
  }
}
