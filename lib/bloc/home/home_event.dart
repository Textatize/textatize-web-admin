part of "home_bloc.dart";

@immutable
abstract class HomeEvent {}

class GetUsers extends HomeEvent {
  final String query;
  final BuildContext context;

  GetUsers({required this.query, required this.context});
}

class ResetHome extends HomeEvent {}
