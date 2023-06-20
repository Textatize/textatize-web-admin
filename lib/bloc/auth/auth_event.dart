part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;
  final bool remember;
  final BuildContext context;

  LoginRequested({
    required this.username,
    required this.password,
    required this.remember,
    required this.context,
  });
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final bool remember;
  final BuildContext context;

  RegisterRequested({
    required this.email,
    required this.password,
    required this.remember,
    required this.context,
  });
}

class CheckIfSignedIn extends AuthEvent {}

class SignOut extends AuthEvent {}
