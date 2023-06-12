import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/ui/universal/popups/error_dialog.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeUnloaded()) {
    on<GetHome>((event, emit) async {
      try {
        emit(HomeLoading());
        await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
        emit(HomeLoaded());
      } catch (e) {
        errorDialog(event.context, e.toString());
        emit(HomeError(error: e.toString()));
      }
    });
  }
}
