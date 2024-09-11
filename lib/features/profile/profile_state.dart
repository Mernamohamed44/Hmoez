part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class NetworkErrorState extends ProfileState {}

class ProfileDataLoadingState extends ProfileState {}

class ProfileDataSuccessState extends ProfileState {}

class ProfileDataFailedState extends ProfileState {
  final String msg;

  ProfileDataFailedState({required this.msg});
}

class LogOutLoadingState extends ProfileState {}

class LogOutSuccessState extends ProfileState {}

class LogOutFailedState extends ProfileState {
  final String msg;

  LogOutFailedState({required this.msg});
}
