import "package:bloc/bloc.dart";
import "package:flutter/material.dart";
import "package:textatize_admin/api/api.dart";
import "package:textatize_admin/ui/universal/popups/error_dialog.dart";

part "auth_event.dart";

part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthUnloaded()) {
    on<RegisterRequested>((event, emit) async {
      try {
        emit(Authenticating());
        if (event.remember) {
          await TextatizeApi().storage.write(key: "remember", value: "true");
        }
        emit(Authenticated());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(UnAuthenticated());
      }
    });
    on<LoginRequested>((event, emit) async {
      try {
        emit(Authenticating());
        if (event.remember) {
          await TextatizeApi().storage.write(key: "remember", value: "true");
        }
        await TextatizeApi().storage.write(
              key: "token",
              value:
                  (await TextatizeApi().login(event.username, event.password))
                      .sessionToken,
            );
        emit(Authenticated());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(UnAuthenticated());
      }
    });

    on<CheckIfSignedIn>((event, emit) async {
      if (await TextatizeApi().storage.read(key: "token") != null &&
          await TextatizeApi().storage.read(key: "remember") != null) {
        try {
          await TextatizeApi().reAuth();
          emit(Authenticated());
        } catch (e) {

          emit(UnAuthenticated());
        }
      }
    });

    on<SignOut>((event, emit) async {
      await TextatizeApi().storage.deleteAll();
      emit(UnAuthenticated());
    });
  }
}
