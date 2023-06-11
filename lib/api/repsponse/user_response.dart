import "../../models/user_model.dart";

class UserResponse {
  final String sessionToken;
  final String error;
  final User? user;

  UserResponse({
    required this.sessionToken,
    required this.error,
    required this.user,
  });
}
