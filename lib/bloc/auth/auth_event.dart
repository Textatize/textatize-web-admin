part of "auth_bloc.dart";

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginRequested(
      {required this.email, required this.password, required this.context,});
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  RegisterRequested(
      {required this.email, required this.password, required this.context,});
}
