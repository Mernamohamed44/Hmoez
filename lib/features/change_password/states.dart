abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class ChangeCurrentVisibilityState extends ChangePasswordStates {}

class ChangeVisibilityState extends ChangePasswordStates {}

class NetworkErrorState extends ChangePasswordStates {}

class ChangePasswordLoadingState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {}

class ChangePasswordFailedState extends ChangePasswordStates {
  final String msg;

  ChangePasswordFailedState({required this.msg});
}

class ConChangeVisibilityState extends ChangePasswordStates {}
