import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:textatize_admin/api/repsponse/user_response.dart";

class TextatizeApi {
  final String host = "devapi.textatizeapp.com";
  final String url = "";
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<UserResponse> login() async {
    throw UnimplementedError();
  }

  Future<UserResponse> register() async {
    throw UnimplementedError();
  }

  Future<UserResponse> reAuth() async {
    throw UnimplementedError();
  }
}
