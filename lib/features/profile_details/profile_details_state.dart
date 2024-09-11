part of 'profile_details_cubit.dart';

@immutable
abstract class ProfileDetailsState {}

class ProfileDetailsInitial extends ProfileDetailsState {}

class NetworkErrorState extends ProfileDetailsState {}

class ChanceVisibilityState extends ProfileDetailsState {}

class UpdateProfileLoadingState extends ProfileDetailsState {}

class UpdateProfileSuccessState extends ProfileDetailsState {}

class UpdateProfileFailedState extends ProfileDetailsState {
  final String msg;

  UpdateProfileFailedState({required this.msg});
}

class UpdatePhoneLoadingState extends ProfileDetailsState {}

class UpdatePhoneSuccessState extends ProfileDetailsState {}

class UpdatePhoneFailedState extends ProfileDetailsState {
  final String msg;

  UpdatePhoneFailedState({required this.msg});
}
