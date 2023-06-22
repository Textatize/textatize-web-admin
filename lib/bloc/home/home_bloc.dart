import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";
import "../../models/user_model.dart";

part "home_event.dart";

part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<User> users = [
    User(
      uniqueId: "one",
      email: "test@email.com",
      enabled: true,
      phone: "293099023",
      created: "Today",
      firstName: "Testing",
      lastName: "Person",
      entityStatus: "active",
      createdFormatted: "Today",
      createdTime: "Time",
      updatedTime: "Time",
      username: "Username",
      points: 10,
    )
  ];
  User? user;

  HomeBloc() : super(HomeUnloaded()) {
    on<GetHome>((event, emit) async {
      try {
        emit(HomeLoading());
        // TODO: REIMPLEMENT
        await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
        // user = (await TextatizeApi().getCurrentUser()).user!;
        // users = (await TextatizeApi().getAllUsers()).users;
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
