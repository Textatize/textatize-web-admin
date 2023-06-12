import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/api/api.dart";
import "package:textatize_admin/ui/universal/popups/error_dialog.dart";

part "auth_event.dart";

part "auth_state.dart";

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticated()) {
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
        emit(Authenticated());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(UnAuthenticated());
      }
    });

    on<CheckIfSignedIn>((event, emit) async {
      emit(Authenticating());
      if (await TextatizeApi().storage.read(key: "token") != null &&
          await TextatizeApi().storage.read(key: "remember") != null) {
        try {
          await TextatizeApi().reAuth();
          emit(Authenticated());
        } catch (_) {
          emit(UnAuthenticated());
        }
      }
      emit(UnAuthenticated());
    });

    on<SignOut>((event, emit) async {
      await TextatizeApi().storage.deleteAll();
      emit(UnAuthenticated());
    });
  }
}
