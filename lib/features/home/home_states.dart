part of 'home_cubit.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeNetworkErrorState extends HomeStates {}

class HomeDataLoadingState extends HomeStates {}

class HomeDataSuccessState extends HomeStates {}

class HomeDataFailedState extends HomeStates {
  final String msg;

  HomeDataFailedState({required this.msg});
}
