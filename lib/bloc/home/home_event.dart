part of "home_bloc.dart";

@immutable
abstract class HomeEvent {}

class GetHome extends HomeEvent {
  final BuildContext context;

  GetHome({required this.context});
}

class ResetHome extends HomeEvent {}
