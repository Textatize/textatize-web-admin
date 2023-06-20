import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/ui/universal/popups/error_dialog.dart";

import "../../models/user_model.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<User> users = [];

  HomeBloc() : super(HomeUnloaded()) {
    on<GetHome>((event, emit) async {
      try {
        emit(HomeLoading());

        emit(HomeLoaded());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(HomeError(error: e.toString()));
      }
    });
    on<ResetHome>((event, emit) {
      emit(HomeUnloaded());
    });
  }
}
