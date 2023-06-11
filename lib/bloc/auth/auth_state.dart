part of "auth_bloc.dart";

@immutable
abstract class AuthState {}

class AuthUnloaded extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {}

class AuthError extends AuthState {}
