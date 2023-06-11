
import "package:bloc/bloc.dart";
import "package:flutter/cupertino.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeUnloaded()) {
    on<HomeEvent>((event, emit) {
    });
  }
}
