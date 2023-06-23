import "dart:convert";
import "package:universal_html/html.dart";
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

  Future<UserResponse> reAuth() async {
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
      UserResponse userResponse =
          UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      return userResponse;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserResponse> toggleUser(String uniqueId, bool enabled) async {
    try {
      String token = "Bearer ${(await storage.read(key: "token"))!}";
      Map<String, dynamic> params = {
        "userId": uniqueId,
      };
      final response = await http.post(
        Uri.https(
          host,
          "${url}admin/user/$uniqueId/${enabled ? "disable" : "enable"}",
        ),
        headers: {"Authorization": token},
        body: params,
      );
      if (jsonDecode(utf8.decode(response.bodyBytes))["error"] != null) {
        throw jsonDecode(utf8.decode(response.bodyBytes))["error"];
      }
      return UserResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getPhoneNumbers(String uniqueId, String username) async {
    try {
      String token = "Bearer ${(await storage.read(key: "token"))!}";
      Map<String, dynamic> params = {
        "userId": uniqueId,
      };
      final response = await http.get(
        Uri.https(
          host,
          "${url}admin/export",
          params,
        ),
        headers: {
          "Authorization": token,
        },
      );
      if (response.statusCode != 200) {
        throw "Unable to download file";
      }
      if(response.bodyBytes.length == 4096) {
        throw "No data for this user!";
      }
      final anchor = AnchorElement(
        href: Url.createObjectUrlFromBlob(
          Blob([response.bodyBytes]),
        ),
      );
      anchor.download = "$username Phone Numbers.xlsx";
      anchor.click();
      anchor.remove();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getEventStats(String uniqueId) async {
    throw UnimplementedError();
  }

  Future<void> editSubscription(
    String uniqueId,
  ) async {
    throw UnimplementedError();
  }

  Future<UsersResponse> getAllUsers(String query, int page) async {
    try {
      String token = "Bearer ${(await storage.read(key: "token"))!}";
      final Map<String, dynamic> params = {
        if(query.isNotEmpty) "query": query,
        "page": page.toString(),
      };
      final response = await http.get(
        Uri.https(
          host,
          "${url}admin/users",
          params,
        ),
        headers: {
          "Authorization": token,
        },
      );

      if (jsonDecode(utf8.decode(response.bodyBytes))["error"] != null) {
        throw jsonDecode(utf8.decode(response.bodyBytes))["error"];
      }
      return UsersResponse.fromJson(
        jsonDecode(utf8.decode(response.bodyBytes)),
      );
    } catch (e) {
      rethrow;
    }
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
