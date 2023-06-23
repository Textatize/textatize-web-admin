import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "package:textatize_admin/api/response/users_response.dart";
import "../../api/api.dart";
import "../../models/user_model.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<User> users = [];
  User? user;
  int page = 0;
  String? previousQuery;
  bool hasMore = true;

  HomeBloc() : super(HomeUnloaded()) {
    on<GetUsers>((event, emit) async {
      if (previousQuery != event.query) {
        hasMore = true;
      }
      if (hasMore) {
        try {
          emit(HomeLoading());
          if (previousQuery != event.query) {
            page = 0;
          } else {
            page++;
          }
          UsersResponse response =
              await TextatizeApi().getAllUsers(event.query, page);
          List<User> result = response.users;
          if (previousQuery != event.query) {
            users = result;
            previousQuery = event.query;
          } else {
            users.addAll(result);
          }
          hasMore = response.hasMore;
          emit(HomeLoaded());
        } catch (e) {
          emit(HomeError(error: e.toString()));
        }
      }
    });

    on<ResetQuery>((event, emit) async {
      try {
        emit(HomeLoading());
        page = 0;
        previousQuery = null;
        users = [];
        hasMore = true;
        UsersResponse response = await TextatizeApi().getAllUsers("", page);
        List<User> result = response.users;
        users = result;
        previousQuery = "";
        hasMore = response.hasMore;
        emit(HomeLoaded());
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });

    on<ResetHome>((event, emit) {
      users = [];
      user;
      page = 0;
      previousQuery = null;
      hasMore = true;
      emit(HomeUnloaded());
    });
  }
}
