part of "home_bloc.dart";

@immutable
abstract class HomeState {}

class HomeUnloaded extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}
