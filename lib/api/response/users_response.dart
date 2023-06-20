import "../../models/user_model.dart";

class UsersResponse {
  final String? error;
  final bool success;
  final String? sessionToken;
  final List<User> users;
  final bool hasMore;

  UsersResponse(
      {required this.error,
        required this.success,
        required this.sessionToken,
        required this.users, required this.hasMore,});

  factory UsersResponse.fromJson(Map<String, dynamic> json) {
    List<User> users = [];
    if (json["users"] != null) {
      List<Map<String, dynamic>> maps =
      (json["users"] as List).cast<Map<String, dynamic>>();
      for (Map<String, dynamic> map in maps) {
        users.add(User.fromJson(map));
      }
    }
    return UsersResponse(
      error: json["error"],
      success: json["isSuccess"],
      sessionToken: json["sessionToken"],
      users: users,
      hasMore: json["has_more"] ?? false,
    );
  }
}
