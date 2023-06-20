import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/api/api.dart";
import "../../models/user_model.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<User> users = [];
  User? user;

  HomeBloc() : super(HomeUnloaded()) {
    on<GetHome>((event, emit) async {
      try {
        emit(HomeLoading());
        user = (await TextatizeApi().getCurrentUser()).user!;
        users = (await TextatizeApi().getAllUsers()).users;
        emit(HomeLoaded());
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });
    on<ResetHome>((event, emit) {
      emit(HomeUnloaded());
    });
  }
}
