import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "../../api/api.dart";
import "../../models/user_model.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<User> users = [];
  User? user;
  int page = 0;
  String previousQuery = "";

  HomeBloc() : super(HomeUnloaded()) {
    on<GetUsers>((event, emit) async {
      try {
        emit(HomeLoading());
        user = (await TextatizeApi().getCurrentUser()).user!;
        users = (await TextatizeApi().getAllUsers(event.query, page)).users;
        emit(HomeLoaded());
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });

    on<ResetHome>((event, emit) {
      emit(HomeUnloaded());
      users = [];
    });
  }
}
