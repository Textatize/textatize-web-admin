import "../../models/user_model.dart";

class UserResponse {
  final String? sessionToken;
  final String? error;
  final User? user;

  UserResponse({
    required this.sessionToken,
    required this.error,
    required this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      sessionToken: json["sessionToken"],
      error: json["error"],
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
    );
  }
}
