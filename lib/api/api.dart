import "dart:convert";
import "package:http/http.dart" as http;
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:textatize_admin/api/response/user_response.dart";
import "package:textatize_admin/api/response/users_response.dart";

class TextatizeApi {
  final String host = "devapi.textatizeapp.com";
  final String url = "";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<UserResponse> login(String username, String password) async {
    try {
      Map<String, dynamic> params = {
        "username": username,
        "password": password,
      };
      final response = await http
          .get(Uri.https(host, "${url}auth/login", params), headers: {});
      if (jsonDecode(utf8.decode(response.bodyBytes))["error"] != null) {
        throw jsonDecode(utf8.decode(response.bodyBytes))["error"];
      }
      return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  Future<UserResponse> register() async {
    throw UnimplementedError();
  }

  Future<UserResponse> reAuth() async {
    throw UnimplementedError();
  }

  Future<void> toggleUser(String uniqueId, bool enabled) async {
    throw UnimplementedError();
  }

  Future<void> getPhoneNumbers(String uniqueId) async {
    throw UnimplementedError();
  }

  Future<void> getEventStats(String uniqueId) async {
    throw UnimplementedError();
  }

  Future<void> editSubscription(String uniqueId) async {
    throw UnimplementedError();
  }

  Future<UsersResponse> getAllUsers() async {
    throw UnimplementedError();
  }

  Future<UserResponse> getCurrentUser() async {
    try {
      String token = "Bearer ${(await storage.read(key: "token"))!}";

      final response = await http.get(
        Uri.https(
          host,
          "${url}user/me",
        ),
        headers: {
          "Authorization": token,
        },
      );
      if (jsonDecode(utf8.decode(response.bodyBytes))["error"] != null) {
        throw jsonDecode(utf8.decode(response.bodyBytes))["error"];
      }
      return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
