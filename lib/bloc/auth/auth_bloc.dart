
import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";

part "auth_event.dart";
part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnloaded()) {
    on<RegisterRequested>((event, emit) async {

    });
    on<LoginRequested>((event, emit) async {

    });
  }
}
