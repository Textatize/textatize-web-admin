import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/ui/universal/popups/error_dialog.dart";

part "auth_event.dart";

part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticated()) {
    on<RegisterRequested>((event, emit) async {
      try {
        emit(Authenticating());

        emit(Authenticated());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(UnAuthenticated());
      }
    });
    on<LoginRequested>((event, emit) async {
      try {
        emit(Authenticating());

        emit(Authenticated());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(UnAuthenticated());
      }
    });

    on<CheckIfSignedIn>((event, emit) async {
      try {
        emit(Authenticating());

        emit(Authenticated());
      } catch (e) {
        emit(UnAuthenticated());
      }
    });

    on<SignOut>((event, emit) async {
      try {
        emit(UnAuthenticated());
      } catch (e) {
        emit(UnAuthenticated());
      }
    });
  }
}
